<side-menu>
			    <b entypo-icon="Stopwatch" id="showAddTask" class="side-menu-icon" standard-icon="" name="V-card" ></b>
			    <b entypo-icon="V-card" class="side-menu-icon" standard-icon="" name="V-card" ></b>
			    <b entypo-icon="User" class="side-menu-icon" standard-icon="" name="V-card" ></b>
			    <b entypo-icon="Credit" class="side-menu-icon" standard-icon="" name="V-card"></b>
		<script>
      var self = this;
      self.attrs = [
      ];
      this.on('mount', function () {
      console.log('SIDEMENU MOUNTED!!!');
        helpers.initPageTag(self);
        document.getElementById('showAddTask').addEventListener('click', function(){
          var theForm = document.getElementById('addTaskTimeForm');
          console.log(theForm.style.display);
          if (theForm.style.display == "none") {
            theForm.style.display = 'block';
          } else {
            theForm.style.display = 'none';
          }
        });
      });

    </script>
</side-menu>