<customer-list>
  
	<customer-listitem each={customer in customers} customer="{customer}"></customer-listitem>
	<script>
    var self = this;
    self.customers = [];
    self.on('mount', function () {
        helpers.initPageTag(self);
        self.customers = store.Customers.storeArray.sort(function (a,b) {
            if (a.totalTimeMonth() < b.totalTimeMonth()) { return 1 }
            if (a.totalTimeMonth() > b.totalTimeMonth()) { return -1 }
            return 0;
        });
        self.update();
    });
    store.Customers.on('collection_changed', function(){
        self.customers = store.Customers.storeArray;
        self.update();
    });
    store.TaskTimes.on('collection_changed', function () {
        self.customers = store.Customers.storeArray.sort(function (a, b) {
            if (a.totalTimeMonth() < b.totalTimeMonth()) { return 1 }
            if (a.totalTimeMonth() > b.totalTimeMonth()) { return -1 }
            return 0;
        });
        self.update();
    });
    self.toggleTimer = function(){
        console.log('toggleTimer');
    }
  </script>
</customer-list>