<employee-dropdown>
    <select name="EmployeeId"  onchange="{changeSelected }">
        <option each="{ employeeList }" id="{ id }" selected="{id==selected}">{ firstname } { lastname }</option>
    </select>
    <script>
      var self = this;
      this.name = opts.name || 'EmployeeId';
      this.employeeList = [];
      this.selected = opts.selected;
      this.changeSelected = function (e) {
      console.log(e.target[e.target.selectedIndex].id);
      this.selected = e.target[e.target.selectedIndex].id;
      this.trigger('selection_changed', e.target[e.target.selectedIndex].id);
      }
      this.on('mount', function () {
        self.employeeList = store.Employees.storeArray;
        self.update();
      });
      store.Employees.on('collection_changed', function () {
      self.employeeList = store.Employees.storeArray;
      self.trigger('selection_changed', self.employeeList[0].id);
      self.update();
      });

    </script>
</employee-dropdown>