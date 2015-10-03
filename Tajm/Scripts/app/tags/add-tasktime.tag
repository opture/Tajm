<add-tasktime>
    <employee-dropdown name="EmployeeId" selected="{tasktime.employeeId}"></employee-dropdown>
    <customer-dropdown name="CustomerId" selected="{tasktime.customerId}"></customer-dropdown>
    <worktask-dropdown name="WorktaskId" selected="{tasktime.worktaskId}"></worktask-dropdown>
    <div style="display:flex;flex-flow:row;margin:0.25rem;">
        <input type="date" name="workDate" />&nbsp;<input type="text" name="duration" placeholder="hh:mm" />
    </div>
    <div style="display:flex;flex-flow:row;">
        <textarea name="description"></textarea>
        <b entypo-icon="Check" onclick="{ saveTaskTime }" standard-icon="" name="saveTaskItem" class="" style="z-index:4;fill:rgba(0,255,0,0.87);"></b>
        <b entypo-icon="Cross" onclick="{ closeMe }" standard-icon="" name="closeMe" class="" style="z-index:4;fill:rgba(255,0,0,0.87);"></b>
    </div>


        <script type="text/javascript">
            var self = this;
            this.tasktime = new TaskTime({});
            self.attrs = [
            { 'scroll-vertical': '' },
            { 'scroll-reveal': 'fadeIn' }
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
            this.saveTaskTime = function (e) {
                //console.log(this.CustomerId.options[this.CustomerId.selectedIndex].value);
                if (!self.duration.value) {
                    alert('Ingen tid angiven');
                    return;
                }
                if (!self.workDate.value) {
                    alert('Inget datum angiven');
                    return;
                }
                var hours = 0, minutes = 0;

                if (self.duration.value.indexOf(':') >= 0) {
                    hours = self.duration.value.split(':')[0];
                    minutes = self.duration.value.split(':')[1];
                } else {
                    minutes = self.duration.value;
                }
                self.tasktime.description = this.description.value;
                var startTime = new Date(self.workDate.value).setHours(0,0,0,0)
                self.tasktime.start = new Date(startTime).toISOString();
                var endTime = new Date(self.workDate.value).setHours(hours, minutes, 0, 0);
                self.tasktime.end = new Date(endTime).toISOString();

                console.log('try to add something');

                store.TaskTimes.addItem(self.tasktime, function (newTask) {
                    self.tasktime = new TaskTime(newTask);
                    self.tasktime.id = 0;
                });
            }

        </script>
</add-tasktime>