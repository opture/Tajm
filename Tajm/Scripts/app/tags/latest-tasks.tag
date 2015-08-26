<latest-tasks>
  <tasktime-listitem each="{latestTasks}" tasktime="{this}"></tasktime-listitem>
  <script>
        var self = this;
        self.latestTasks = [];
        store.TaskTimes.on('collection_changed', function () {
            self.latestTasks = store.TaskTimes.storeArray.filter(function (task) {
                return task.end;
            });
            self.latestTasks.sort(function (a, b) {
                if (a.end < b.end) {
                    return 1;
                }
                if (a.end > b.end) {
                    return -1;
                }
                // a must be equal to b
                return 0;
            });
            self.update();
        });

    </script>
</latest-tasks>