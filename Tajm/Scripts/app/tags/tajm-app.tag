<tajm-app>
    <div fit style="display:flex;flex-flow:column;">
        <side-menu></side-menu>
        <customer-list></customer-list>
        <add-tasktime id="addTaskTimeForm" style="margin:0 auto;display:none;background:rgba(0,0,0,0.7)"></add-tasktime>
    </div>	
	<script>
    var currentEmployee = store.Employees.storeArray.find(function(_e){
    return _e.userId == loggedInUserId;
    });
    console.log(loggedInUserId);
    console.log(currentEmployee)
  </script>
</tajm-app>