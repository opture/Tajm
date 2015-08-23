<latest-tasks>
    <table>
        <tr>
            <th>Kund</th>
            <th>Person</th>
            <th>Uppgift</th>
            <th>Start</th>
            <th>Slut</th>
        </tr>
        <tr each="{latestTasks}">
            <td>{customerId}</td>
            <td>{employeeId}</td>
            <td>{taskId}</td>
            <td>{start}</td>
            <td>{end.substring(0,10)}</td>
        </tr>
    </table>
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