<current-tasks>
    <tasktime-active each="{currentTasks}" tasktime="{this}">
    </tasktime-active>
    <script>
        var self = this;
        self.currentTasks = [];
        store.TaskTimes.on('collection_changed', function () {
            self.currentTasks = store.TaskTimes.storeArray.filter(function (task) {
                return !task.end;
            });
            self.update();
        });
        self.on('mount', function () {
            setInterval(self.update, 1000);
        });

        
    </script>
</current-tasks>