


var storesToLoad = [
    store.Customers,
    store.WorkTasks,
    store.Employees,
    store.TaskTimes
];
storesLoaded = 0;
storesToLoad.forEach(function (_s) {
    _s.one('store_initialized', function () {
        console.log('inited:');
        console.log(_s);
        storesLoaded++;
        console.log(storesLoaded);
        console.log(storesToLoad.length);
        if (storesLoaded == storesToLoad.length) {
            store.trigger('stores_initialized');
            console.log()
        }
    });
    _s.initStore();
});
//store.Customers.initStore();
//store.WorkTasks.initStore();
//store.Employees.initStore();
//store.TaskTimes.initStore();
//store.currentTasks.initStore();

