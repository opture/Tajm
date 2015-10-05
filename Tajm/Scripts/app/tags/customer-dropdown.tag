<customer-dropdown>
    <select name="CustomerId" onchange="{changeSelected }">
        <option each="{ customerList }" id="{ id }" selected="{id==selected}">{ name }</option>
    </select>
    <script>
        var self = this;
        this.name = opts.name || 'CustomerId';
        this.customerList = [];
        this.selected = opts.selected;
        this.changeSelected = function (e) {
            console.log(e.target[e.target.selectedIndex].id);
            this.selected = e.target[e.target.selectedIndex].id;
            this.trigger('selection_changed', e.target[e.target.selectedIndex].id);
        }
        this.on('mount', function () {
            self.customerList = store.Customers.storeArray;
            self.update();
        });
        store.Customers.on('collection_changed', function () {
            self.customerList = store.Customers.storeArray;
            self.trigger('selection_changed', self.customerList[0].id);
            self.update();
        });

    </script>
</customer-dropdown>