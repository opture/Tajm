<worktask-picker>
    <div each="{ worktaskList }" id="{ id }" if="{id != 11}" onclick="{ setSelected }">{ name } ({ price }:-)</div>
    <script type="text/javascript">
        var self = this;
        this.name = opts.name || 'WorkTaskId';
        this.worktaskList = [];
        this.selected = opts.selected;
        this.on('SELECTION_CHANGED', function () {
            console.log('it works here at least');
        })
        this.setSelected = function (e) {
            console.log('selected changed: ' + e.item.id);
            self.trigger('SELECTION_CHANGED', e.item.id);
        };

        this.on('mount', function () {
            self.worktaskList = store.WorkTasks.storeArray;
            self.update();
        });

        store.WorkTasks.on('collection_changed', function () {
            self.worktaskList = store.WorkTasks.storeArray;
            self.trigger('SELECTION_CHANGED', self.worktaskList[0].id);
            self.update();
        });

    </script>
</worktask-picker>