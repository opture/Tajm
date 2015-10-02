<tasktime-active>
      <div>
        <b onclick="{ stopTimer }" standard-icon="" entypo-icon="Stopwatch" style="fill:rgba(255,0,0,0.87);"></b>
      </div>
      <div>{moment.duration(moment().unix() - moment(tasktime.start).unix(), "seconds").format('hh:mm:ss',{ forceLength: true })}</div>
    <div style="display:flex;flex-flow:column">
        <div>{tasktime.customer.name}</div>
        <div>{tasktime.task.name}</div>
    </div>
    <script>
      var self = this;
      this.tasktime = opts.tasktime;
      this.workedTime = 0;
      this.on('mount', function () {
        helpers.initPageTag(self);
      });
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

