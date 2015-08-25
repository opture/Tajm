<tasktime-active>
    <div style="display:flex;flex-flow:column">
        <div>{tasktime.customer.name}</div>
        <div>{tasktime.task.name}</div>
    </div>
    <div style="display:flex;flex-flow:column">
        <div>{moment.duration(moment().unix() - moment(tasktime.start).unix(), "seconds").format('hh:mm:ss',{ forceLength: true })}</div>
        <div><img onclick="{ stopTimer }" src="/Content/images/digital-timer-stop.svg" width="16" hieght="16" /></div>
    </div>
        <script>
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

        </script>
</tasktime-active>

