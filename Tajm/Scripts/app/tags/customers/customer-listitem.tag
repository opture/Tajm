<customer-listitem>
    <div>
        <div style="display:flex;flex-flow:row;">
            <b onclick="{ startTimer }" show="{!customer.activeTask}" medium-icon="" entypo-icon="Play" style="fill:green"></b>
            <b onclick="{ stopTimer }" show="{customer.activeTask}" class="spinSlow" medium-icon="" entypo-icon="Stop" style="fill:rgba(255,0,0,0.87);"></b>
            <b onclick="{ callTo }" medium-icon="" entypo-icon="Phone" style="fill:#fa5606;"></b>
        </div>
        <div style="display:flex;flex-flow:row;">
            <b onclick="{ toggleInfo }" medium-icon="" entypo-icon="Info" style="fill:#fa5606;"></b>
            <b onclick="{ toggleInfo }" medium-icon="" entypo-icon="Credit" style="fill:#fa5606;"></b>
        </div>

    </div>
    <div>
        <h4>{customer.name}</h4>
        <p><label>Idag</label><span style="float:right">{customer.totalTimeDay()}</span></p>
        <p><label>{moment().format('MMMM')}</label><span style="float:right;">{customer.totalTimeMonth()}</span></p>
        
    </div>
    <div if="{showInfo}" onclick="{ toggleInfo}"style="padding:1rem;z-index:3;position:absolute;top:4rem;left:2rem;height:30rem;max-height:30rem;overflow:scroll;display:block;background:black;border-radius:1rem;border:1px solid white;">
        <h3>{customer.name}</h3>
        <div each="{task in customer.taskTimes}" style="margin-bottom:0.5rem;" >
            {moment(task.start).format('YYYY-MM-DD')} <strong>{task.duration}</strong><br />
            {task.description}<hr />
        </div>
    </div>
    <worktask-picker name="chooseTasker" class="{active: chooseTask}"></worktask-picker>
    
    <form class="{active: addDescription}" onsubmit="{ updateTask }">
        <textarea cols="50" rows="4" name="taskDescription" onkeydown="{ keyDownDescription }"></textarea>
        <button >Spara</button>
    </form>
    <script>
        var self = this;
        self.customer = opts.customer;
        self.currentTaskId = null;
        self.addDescription = false;
        self.chooseTask = false;
        self.showInfo = false;
        self.taskRegisterInProgress = false; //Prevent multiple requests for the same action.
        self.on('mount', function () {
            helpers.initPageTag(self);
            console.log(self.chooseTasker._tag);
            self.customer.on('tasks_loaded', function () {
                self.update();
            });
            //When the selected taks changes.
            setTimeout(function () {
                self.chooseTasker._tag.on('SELECTION_CHANGED', function (newTaskId) {
                    console.log('we got a change in this.');
                    self.currentTaskId = newTaskId;
                    self.chooseTask = false;
                    self.update();
                    self.addTask();
                });
            }, 1);

        });


        self.toggleInfo = function () {
            self.showInfo = !self.showInfo;
        };
        self.startTimer = function (e) {
            if (self.customer.id == 7) { //arbetstid
                self.currentTaskId = 11;
                self.addTask();
                return;
            }
            self.chooseTask = true;
            self.update();
            setTimeout(function () {
                document.addEventListener('click', self.hideTaskChooser);
            }, 250);
            
        };
        self.hideTaskChooser = function (e) {
            console.log(e);
            self.chooseTask = false;
            self.update();
            document.removeEventListener('click', self.hideTaskChooser);
        };

        self.stopTimer = function () {
            self.addDescription = true;
        };
        self.keyDownDescription = function(e){
            if (e.ctrlKey && e.keyCode==13){
                console.log('Pressed ctrl + enter');
                self.updateTask();
                return false;
            }
            return true;
        };


        self.addTask = function () {
            if (self.taskRegisterInProgress) { return; } //Prevent multiple requests for the same action.
            if (!self.customer.activeTask) {
                self.taskRegisterInProgress = true;
                //Create a new tasktime.
                var newTaskTime = new TaskTime({});

                newTaskTime.customerId = self.customer.id;
                newTaskTime.employeeId = window.user.id;
                newTaskTime.taskId = self.currentTaskId;
                newTaskTime.start = new Date().toISOString();
                self.customer.activeTask = newTaskTime;
                self.update();

                //Store the tasktime.
                self.customer.addTask(newTaskTime, {
                    success: function (newTask) {
                        self.customer.activeTask = newTask;
                        self.taskRegisterInProgress = false;
                    },
                    error: function () {
                        self.customer.activeTask = null;
                        self.taskRegisterInProgress = false;
                        alert('Ett fel inträffade när tiden skulle registreras.')
                    }
                });
                self.update();
            }
        };

        self.updateTask = function () {
            console.log('Update task');
            if (!self.customer.activeTask) return;
            self.addDescription = false;
            self.taskRegisterInProgress = true;

            self.customer.activeTask.end = new Date().toISOString();
            self.customer.activeTask.description = self.taskDescription.value;
            self.taskDescription.value = null;
            store.TaskTimes.updateItem(self.customer.activeTask, function () {
                self.customer.activeTask = null;
                self.taskRegisterInProgress = false;
                self.update();
            });
        };
    </script>
</customer-listitem>