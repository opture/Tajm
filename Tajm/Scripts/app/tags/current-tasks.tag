<current-tasks>
    <table>
        <tr>
            <th>Kund</th>
            <th>Person</th>
            <th>Uppgift</th>
            <th>Start</th>
            <th></th>
        </tr>
        <tr each="{currentTasks}">
            <td>{customerId}</td>
            <td>{employeeId}</td>
            <td>{taskId}</td>
            <td>{start}</td>
            <td><button onclick="{ stopTimer }">Stopp</button></td>
        </tr>
    </table>
    <script>
        var self = this;
        self.currentTasks = [];
        store.TaskTimes.on('collection_changed', function () {
            self.currentTasks = store.TaskTimes.storeArray.filter(function (task) {
                return !task.end;
            });
            self.update();
        });
        self.stopTimer = function (e) {
            console.log(e.item);
            e.item.end = new Date().toJSON();
            store.TaskTimes.updateItem(e.item, function () {
                self.update();
            });
            
        }
    </script>
</current-tasks>