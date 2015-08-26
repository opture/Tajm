var Customer = function (opts) {
    opts = opts || {};
    this.id = opts.id || opts.Id;
    this.name = opts.name || opts.Name;
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
    this.start = opts.start || opts.Start;
    this.end = opts.end || opts.End;
    this.customer = {};
    this.employee = {};
    this.task = {};
    (this.initcustomer = function () {
        store.Customers.getItem(self.customerId, function (cust) {
            self.customer = cust;
        });
        
    })();
    (this.initEmployee = function () {
        store.Employees.getItem(self.employeeId, function (emp) {
            self.employee = emp;
        });
    })();
    (this.initTask = function () {
        store.WorkTasks.getItem(self.taskId, function (_task) {
            self.task = _task;
        });
    })();
}


