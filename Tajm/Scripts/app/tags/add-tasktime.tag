<add-tasktime>
    <employee-dropdown name="EmployeeId" selected="{tasktime.employeeId}"></employee-dropdown>
    <customer-dropdown name="CustomerId" selected="{tasktime.customerId}"></customer-dropdown>
    <worktask-dropdown name="WorktaskId" selected="{tasktime.worktaskId}"></worktask-dropdown>
  <div style="display:flex;flex-flow:row;">
    <textarea name="description"></textarea>
    <b entypo-icon="Play" onclick="{ startTaskTime }" standard-icon="" name="addTaskItem" class="" style="z-index:4;fill:rgba(0,255,0,0.87);"></b>
  </div>


  <script type="text/javascript">
        var self = this;
        this.tasktime = new TaskTime({});
        self.attrs = [
        { 'scroll-vertical': '' },
        { 'scroll-reveal': 'fadeIn' },
        { 'center-vert': '' }
        ];
        this.on('mount', function () {
            helpers.initPageTag(self);
        });
        //this.tasktime = opts.tasktime || new TaskTime();
        this.CustomerId._tag.on('selection_changed', function (newVal) {
            self.tasktime.customerId = newVal * 1;
        });
        this.EmployeeId._tag.on('selection_changed', function (newVal) {
            self.tasktime.employeeId = newVal * 1;
        });
        this.WorktaskId._tag.on('selection_changed', function (newVal) {
            self.tasktime.taskId = newVal * 1;
        });
        this.startTaskTime = function (e) {
            //console.log(this.CustomerId.options[this.CustomerId.selectedIndex].value);
            var doesExists = store.TaskTimes.storeArray.filter(function (val) {
                return !val.end && 
                    (val.customerId == self.tasktime.customerId && 
                    val.employeeId == self.tasktime.employeeId &&
                    val.taskId == self.tasktime.taskId
                    )
            });

            if (doesExists.length > 0) {
                alert('Hej kompis! du har redan satt igång den timern.');
                return false;
            }

            self.tasktime.description = this.description.value;
            self.tasktime.start = new Date().toJSON();

            console.log('try to add something');

            store.TaskTimes.addItem(self.tasktime, function (newTask) {
                self.tasktime = new TaskTime(newTask);
                self.tasktime.id = 0;
            });
        }

    </script>
</add-tasktime>