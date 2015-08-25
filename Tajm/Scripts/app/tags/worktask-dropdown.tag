<worktask-dropdown>
    <select name="{ name }" onchange="{changeSelected }">
        <option each="{ worktaskList }" id="{ id }" selected="{id==selected}">{ name } ({ price }:-)</option>
    </select>
    <script>
        var self = this;
        this.name = opts.name || 'WorkTaskId';
        this.worktaskList = [];
        this.selected = opts.selected;
        this.changeSelected = function (e) {
            console.log(e.target[e.target.selectedIndex].id);
            this.selected = e.target[e.target.selectedIndex].id;
            this.trigger('selection_changed', e.target[e.target.selectedIndex].id);
        }
        this.on('update', function () {
        });
        store.WorkTasks.on('collection_changed', function () {
            self.worktaskList = store.WorkTasks.storeArray;
            self.trigger('selection_changed', self.worktaskList[0].id);
            self.update();
        });

    </script>
</worktask-dropdown>