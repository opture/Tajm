<side-menu>
			    <b entypo-icon="Stopwatch" onclick="{addTaskTime}" id="showAddTask" class="side-menu-icon" standard-icon="" name="V-card" ></b>
			    <b entypo-icon="V-card" class="side-menu-icon" standard-icon="" name="V-card" ></b>
			    <b entypo-icon="User" class="side-menu-icon" standard-icon="" name="V-card" ></b>
			    <b entypo-icon="Tools" class="side-menu-icon" standard-icon="" name="V-card"></b>
		<script>
      var self = this;
      self.attrs = [
      ];
      this.on('mount', function () {
      console.log('SIDEMENU MOUNTED!!!');
        helpers.initPageTag(self);
        
      });
      this.addTaskTime =  function(e){
          var theForm = document.getElementById('addTaskTimeForm');
          console.log(theForm.style.display);
          if (theForm.style.display == "none") {
              theForm.style.display = 'block';
              console.log(e);
              if (e.target.tagName == 'svg') {
                  theForm.style.left = e.target.offsetParent.offsetLeft + 'px';
              } else {
                  theForm.style.left = e.target.offsetLeft + 'px';
              }
              
          } else {
              theForm.style.display = 'none';
          }
      };
    </script>
</side-menu>