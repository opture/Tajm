riot.tag('add-tasktime', '<employee-dropdown name="EmployeeId" __selected="{tasktime.employeeId}"></employee-dropdown><customer-dropdown name="CustomerId" __selected="{tasktime.customerId}"></customer-dropdown><worktask-dropdown name="WorktaskId" __selected="{tasktime.worktaskId}"></worktask-dropdown><textarea name="description"></textarea><button name="startTaskTime" onclick="{startTaskTime}">Starta</button>', function(opts) {
        var self = this;
        this.tasktime = new TaskTime({});

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

            this.tasktime.description= this.description.value;
            this.tasktime.start = new Date().toJSON();

            console.log(this.tasktime);
            console.log('try to add somethins');
            store.TaskTimes.addItem(self.tasktime, function (newTask) {
                self.tasktime = new TaskTime(newTask);
                self.tasktime.id = 0;
            });
        }

    
});riot.tag('current-tasks', '<table><tr><th>Kund</th><th>Person</th><th>Uppgift</th><th>Start</th><th></th></tr><tr each="{currentTasks}"><td>{customerId}</td><td>{employeeId}</td><td>{taskId}</td><td>{start}</td><td><button onclick="{stopTimer}">Stopp</button></td></tr></table>', function(opts) {
        var self = this;
        self.currentTasks = [];
        store.TaskTimes.on('collection_changed', function () {
            self.currentTasks = store.TaskTimes.storeArray.filter(function (task) {
                return !task.end;
            });
            self.update();
        });
        self.stopTimer = function (e) {
            console.log(e.item);
            e.item.end = new Date().toJSON();
            store.TaskTimes.updateItem(e.item, function () {
                self.update();
            });
            
        }
    
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

    
});riot.tag('worktask-dropdown', '<select name="{name}" onchange="{changeSelected}"><option each="{worktaskList}" id="{id}" __selected="{id==selected}">{name} ({price}:-)</option></select>', function(opts) {
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
            console.log("I've got a indication that employees are loaded");
            self.worktaskList = store.WorkTasks.storeArray;
            self.trigger('selection_changed', self.worktaskList[0].id);
            self.update();
        });

    
});