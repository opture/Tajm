riot.tag('add-tasktime', '<employee-dropdown name="EmployeeId" __selected="{tasktime.employeeId}"></employee-dropdown><customer-dropdown name="CustomerId" __selected="{tasktime.customerId}"></customer-dropdown><worktask-dropdown name="WorktaskId" __selected="{tasktime.worktaskId}"></worktask-dropdown><textarea name="description"></textarea><img name="startTaskTime" onclick="{startTaskTime}" src="/Content/images/digital-timer-start.svg" height="64" width="64">', function(opts) {
        var self = this;
        this.tasktime = new TaskTime({});
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

    
});riot.tag('current-tasks', '<tasktime-active each="{currentTasks}" tasktime="{this}"></tasktime-active>', function(opts) {
        var self = this;
        self.currentTasks = [];
        store.TaskTimes.on('collection_changed', function () {
            self.currentTasks = store.TaskTimes.storeArray.filter(function (task) {
                return !task.end;
            });
            self.update();
        });
        self.on('mount', function () {
            setInterval(self.update, 1000);
        });

        
    
});riot.tag('customer-dropdown', '<select name="CustomerId" onchange="{changeSelected}"><option each="{customerList}" id="{id}" __selected="{id==selected}">{name}</option></select>', function(opts) {
        var self = this;
        this.name = opts.name || 'CustomerId';
        this.customerList = [];
        this.selected = opts.selected;
        this.changeSelected = function (e) {
            console.log(e.target[e.target.selectedIndex].id);
            this.selected = e.target[e.target.selectedIndex].id;
            this.trigger('selection_changed', e.target[e.target.selectedIndex].id);
        }
        this.on('update', function () {
        });
        store.Customers.on('collection_changed', function () {
            self.customerList = store.Customers.storeArray;
            self.trigger('selection_changed', self.customerList[0].id);
            self.update();
        });

    
});riot.tag('employee-dropdown', '<select name="EmployeeId" onchange="{changeSelected}"><option each="{employeeList}" id="{id}" __selected="{id==selected}">{firstname} {lastname}</option></select>', function(opts) {
        var self = this;
        this.name = opts.name || 'EmployeeId';
        this.employeeList = [];
        this.selected = opts.selected;
        this.changeSelected = function (e) {
            console.log(e.target[e.target.selectedIndex].id);
            this.selected = e.target[e.target.selectedIndex].id;
            this.trigger('selection_changed', e.target[e.target.selectedIndex].id);
        }
        this.on('update', function () {
        });
        store.Employees.on('collection_changed', function () {
            console.log("I've got a indication that employees are loaded");
            self.employeeList = store.Employees.storeArray;
            self.trigger('selection_changed', self.employeeList[0].id);
            self.update();
        });

    
});riot.tag('latest-tasks', '<tasktime-listitem each="{latestTasks}" tasktime="{this}"></tasktime-listitem>', function(opts) {
        var self = this;
        self.latestTasks = [];
        store.TaskTimes.on('collection_changed', function () {
            self.latestTasks = store.TaskTimes.storeArray.filter(function (task) {
                return task.end;
            });
            self.latestTasks.sort(function (a, b) {
                if (a.end < b.end) {
                    return 1;
                }
                if (a.end > b.end) {
                    return -1;
                }

                return 0;
            });
            self.update();
        });

    
});riot.tag('tasktime-active', '<div style="display:flex;flex-flow:column"><div>{tasktime.customer.name}</div><div>{tasktime.task.name}</div></div><div style="display:flex;flex-flow:column"><div>{moment.duration(moment().unix() - moment(tasktime.start).unix(), "seconds").format(\'hh:mm:ss\',{ forceLength: true})}</div><div><img onclick="{stopTimer}" src="/Content/images/digital-timer-stop.svg" width="16" hieght="16"></div></div>', function(opts) {
            var self = this;
            this.tasktime = opts.tasktime;
            this.workedTime = 0;

            self.stopTimer = function (e) {
                console.log(e.item);
                e.item.end = new Date().toJSON();
                store.TaskTimes.updateItem(e.item, function () {
                    self.update();
                });

            }

            this.tasktime.on('customer_updated', function () {
                self.update();
            });
            this.tasktime.on('employee_updated', function () {
                self.update();
            });
            this.tasktime.on('task_updated', function () {
                self.update();
            });

        
});

riot.tag('tasktime-listitem', '<div>{tasktime.customer.name}</div><div>{tasktime.task.name}</div><div>{tasktime.employee.firstname}</div><div>{moment.duration(moment(tasktime.end).unix() - moment(tasktime.start).unix(),"seconds").format(\'hh:mm:ss\',{ forceLength: true})}</div>', function(opts) {
    var self = this;
    this.tasktime = opts.tasktime;
    this.workedTime = 0;

    this.tasktime.on('customer_updated', function(){
    self.update();
    });
    this.tasktime.on('employee_updated', function(){
    self.update();
    });
    this.tasktime.on('task_updated', function(){
    self.update();
    });
    
  
});

riot.tag('worktask-dropdown', '<select name="{name}" onchange="{changeSelected}"><option each="{worktaskList}" id="{id}" __selected="{id==selected}">{name} ({price}:-)</option></select>', function(opts) {
        var self = this;
        this.name = opts.name || 'WorkTaskId';
        this.worktaskList = [];
        this.selected = opts.selected;
        this.changeSelected = function (e) {
            console.log(e.target[e.target.selectedIndex].id);
            this.selected = e.target[e.target.selectedIndex].id;
            this.trigger('selection_changed', e.target[e.target.selectedIndex].id);
        }
        this.on('update', function () {
        });
        store.WorkTasks.on('collection_changed', function () {
            self.worktaskList = store.WorkTasks.storeArray;
            self.trigger('selection_changed', self.worktaskList[0].id);
            self.update();
        });

    
});