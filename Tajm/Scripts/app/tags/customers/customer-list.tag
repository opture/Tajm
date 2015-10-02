<customer-list>
  
	<customer-listitem each={customer in customers} customer="{customer}"></customer-listitem>
	<script>
		var self = this;
		self.customers = [];
		self.on('mount', function () {
			helpers.initPageTag(self);
		});
		store.Customers.on('collection_changed', function(){
			self.customers = store.Customers.storeArray;
			self.update();
		});
		self.toggleTimer = function(){
			console.log('toggleTimer');
		}
	</script>
</customer-list>