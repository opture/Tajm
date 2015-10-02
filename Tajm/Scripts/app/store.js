
var storeSection = function (opts) {
    opts = opts || {};
    riot.observable(this);
    var self = this;
    this.apiUrl = opts.apiUrl || '';
    this.storeType = opts.storeType || Object;
    this.store = {};
    this.storeArray = [];
    //Simple init function for store.
    this.initStore = function () {
        $.get(self.apiUrl, function (data) {
            data.forEach(function (_customer) {
                self.internalAddItem(new self.storeType(_customer));
            });
            self.trigger('collection_changed');
        });

        
    };
    //Simle function to add object to store.
    this.addItem = function (itemToAdd, callback) {
        if (!itemToAdd.id && self.apiUrl) {
            itemToAdd.id = 0;
            $.post(self.apiUrl, itemToAdd, function (data) {

                //Add to stores.
                itemToAdd.id = data.Id;
                self.internalAddItem(itemToAdd);
                if (callback) { callback(itemToAdd);}
            });
        } else {
            //Add to stores.
            self.internalAddItem(itemToAdd);
            if (callback) { callback(itemToAdd); }
        }
    }
    this.updateItem = function (itemToUpdate, callback) {
        $.ajax({
            url: self.apiUrl + '/' + itemToUpdate.id,
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(itemToUpdate),
            success: function (data) {
                self.trigger('collection_changed');
                if (callback) { callback(itemToUpdate)}
            }
        });
    }
    //
    //Insert item in stores.
    this.internalAddItem = function (itemToAdd) {
        //Add to kvp.
        if (!itemToAdd.id) { return; }
        self.store[itemToAdd.id] = itemToAdd;
        //Add to array.
        self.storeArray.push(itemToAdd);
        //Tell the system there is a new item.
        self.trigger('collection_changed', itemToAdd);
    }
    //Just simple helper to fetch a specific Id.
    this.getItem = function (id, callback) {
        if (!id) { return;}
        var retVal = self.store[id];
        if (!retVal) {
            $.get(self.apiUrl + '/' + id, function (data) {
                self.internalAddItem(data);
                callback(self.store[id])
                self.trigger('Item_fetched', self.store[id]);
            });
        } else {
            self.trigger('Item_fetched', self.store[id]);
            callback(self.store[id])
            return self.store[id];
        }
        
    }
}

var store = {
    Customers: new storeSection({ apiUrl: '/api/customers', storeType: Customer }),
    WorkTasks: new storeSection({ apiUrl: '/api/WorkTasks', storeType: WorkTask }),
    Employees: new storeSection({ apiUrl: '/api/Employees', storeType: Employee }),
    TaskTimes: new storeSection({ apiUrl: '/api/TaskTimes', storeType: TaskTime }),
    currentTasks: new storeSection({ apiUrl: '/api/TaskTimes', storeType: TaskTime }),
    lastFinishedTasks: new storeSection({ apiUrl: '/api/TaskTimes', storeType: TaskTime }),
};

