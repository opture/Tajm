var Customer = function (opts) {
    riot.observable(this);
    var self = this;
    opts = opts || {};
    this.id = opts.id || opts.Id;
    this.name = opts.name || opts.Name;
    this.taskTimes = [];
    this.activeTask = null;
    this.updateTaskTimes = function () {
        self.taskTimes = store.TaskTimes.getItemsByCustomerId(self.id);
        self.activeTask = self.taskTimes.find(function (_t) {
            return !_t.end;
        });
        self.trigger('tasks_loaded');
    };
    (this.initTasks = function () {
            if (store.TaskTimes && store.TaskTimes.storeArray.length > 1) {
                self.updateTaskTimes();
            } else {
                store.TaskTimes.one('collection_changed', function () {
                    self.updateTaskTimes();
                });
            }
    })();
    
    this.addTask = function (taskToAdd, options) {
        options = options || {};
        store.TaskTimes.addItem(taskToAdd, function (item) {
            self.updateTaskTimes();
            self.trigger('customer-changed', self);
            if (options.success) {
                options.success(item);
            }
        });
    };
    this.totalTimeMonth = function () {
        var retVal = 0;
        for (var x = 0; x < self.taskTimes.length; x++) {
            curTaskTime = self.taskTimes[x];
            //Check that there is an end timestamp to this one. 
            if (curTaskTime.end && moment(curTaskTime.end).format('yyyyMM') == moment().format('yyyyMM')) {
                retVal += moment(curTaskTime.end).unix() - moment(curTaskTime.start).unix();
            }
        }
        return moment.duration(retVal, "seconds").format('hh:mm', { forceLength: true });
    };
    this.totalTimeDay = function () {
        var retVal = 0;
        for (var x = 0; x < self.taskTimes.length; x++) {
            curTaskTime = self.taskTimes[x];
            //Check that there is an end timestamp to this one. 
            if (curTaskTime.end && moment(curTaskTime.end).format('yyyyMMdd') == moment().format('yyyyMMdd')) {
                retVal += moment(curTaskTime.end).unix() - moment(curTaskTime.start).unix();
            }
        }
        return moment.duration(retVal, "seconds").format('hh:mm', { forceLength: true });
    };
}


var WorkTask = function (opts) {
    opts = opts || {};
    this.id = opts.id || opts.Id;
    this.name = opts.name || opts.Name;
    this.price = opts.price || opts.Price;
};

var Employee = function (opts) {
    opts = opts || {};
    this.id = opts.id || opts.Id;
    this.firstname = opts.firstname || opts.FirstName;
    this.lastname = opts.lastname || opts.LastName;
}


var TaskTime = function (opts) {
    opts = opts || {};
    var self = this;
    this.id = opts.id || opts.Id;
    this.customerId = opts.customerId || opts.CustomerId;
    this.employeeId = opts.employeeId || opts.EmployeeId;
    this.taskId = opts.taskId || opts.TaskId;
    this.description = opts.description || opts.Description;
    this.start = opts.start ? new Date(opts.start).toISOString() : null || opts.Start ? new Date(opts.Start).toISOString() : null;
    this.end = opts.end ? new Date(opts.end).toISOString() : null || opts.End ? new Date(opts.End).toISOString() : null;
    this.customer = function () {
        return store.Customers.getItem(self.customerId, function (cust) {
            return cust;
        });
    };
    this.employee = function () {
        return store.Employees.getItem(self.employeeId, function (emp) {
            return emp;
        });
    };
    this.task = function () {
        return store.WorkTasks.getItem(self.taskId, function (_task) {
            return _task;
        });
    };
}


