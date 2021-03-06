﻿<tasktime-listitem>
    <div class="left-column">
        <div id="customerName">{moment(tasktime.start).format('hh:mm')}</div>
        <div id="taskName">{tasktime.task.name}</div>
    </div>
    <div class="right-column">
        <div id="employeeName">{moment(tasktime.end).format('hh:mm')}</div>
        <div id="elapsedTime">{moment.duration(moment(tasktime.end).unix() - moment(tasktime.start).unix(),"seconds").format('hh:mm:ss',{ forceLength: true })}</div>
    </div>
        <script>
            var self = this;
            this.tasktime = opts.tasktime;
            this.workedTime = 0;

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
</tasktime-listitem>

