<employee-dropdown>
    <select name="EmployeeId"  onchange="{changeSelected }">
        <option each="{ employeeList }" id="{ id }" selected="{id==parent.selected}">{ firstname } { lastname }</option>
    </select>
    <script>
      var self = this;
      this.name = opts.name || 'EmployeeId';
      this.employeeList = [];
      this.selected = opts.selected ;
      this.changeSelected = function (e) {
        console.log(e.target[e.target.selectedIndex].id);
        this.selected = e.target[e.target.selectedIndex].id;
        this.trigger('selection_changed', e.target[e.target.selectedIndex].id);
      }
      this.on('mount', function () {
          console.log('selected employee');
          console.log(self.selected);
          self.employeeList = store.Employees.storeArray;
          if (!self.selected) { self.selected = self.employeeList[0].id }
          console.log('now selected employee');
          console.log(self.selected);
          self.update();
          this.trigger('selection_changed', self.selected);
      });
      store.Employees.on('collection_changed', function () {
        self.employeeList = store.Employees.storeArray;
        if (!self.selected) { self.selected = self.employeeList[0].id }
        self.trigger('selection_changed', self.selected);
        self.update();
      });

    </script>
</employee-dropdown>