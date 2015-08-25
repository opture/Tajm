<tasktime-listitem>
    <div>{tasktime.customer.name}</div>
    <div>{tasktime.task.name}</div>
    <div>{tasktime.employee.firstname}</div>
    <div>{moment.duration(moment(tasktime.end).unix() - moment(tasktime.start).unix(),"seconds").format('hh:mm:ss',{ forceLength: true })}</div>
  <script>
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
    
  </script>
</tasktime-listitem>

