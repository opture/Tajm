﻿<add-tasktime>
    <employee-dropdown name="EmployeeId" selected="{tasktime.employeeId}"></employee-dropdown>
    <customer-dropdown name="CustomerId" selected="{tasktime.customerId}"></customer-dropdown>
    <worktask-dropdown name="WorktaskId" selected="{tasktime.worktaskId}"></worktask-dropdown>
    <textarea name="description"></textarea>
    <button name="startTaskTime" onclick="{ startTaskTime }">Starta</button>
    <script>
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

            this.tasktime.description= this.description.value;
            this.tasktime.start = new Date().toJSON();

            console.log(this.tasktime);
            console.log('try to add somethins');
            store.TaskTimes.addItem(self.tasktime, function (newTask) {
                self.tasktime = new TaskTime(newTask);
                self.tasktime.id = 0;
            });
        }

    </script>
</add-tasktime>