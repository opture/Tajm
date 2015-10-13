<side-menu>
			    <b entypo-icon="Stopwatch" onclick="{addTaskTime}" id="showAddTask" class="side-menu-icon" standard-icon="" name="V-card" ></b>
			    <b entypo-icon="V-card" class="side-menu-icon" standard-icon="" name="V-card" ></b>
			    <b entypo-icon="User" class="side-menu-icon" standard-icon="" name="V-card" ></b>
			    <b entypo-icon="Tools" class="side-menu-icon" standard-icon="" name="V-card"></b>
                <form onclick="{ logOut }" onsubmit="{ logOut }">
                    <b entypo-icon="Log_out" class="side-menu-icon" standard-icon="" name="V-card"></b>
                </form>
		<script>
      var self = this;
      self.attrs = [
      ];
      this.on('mount', function () {
      console.log('SIDEMENU MOUNTED!!!');
        helpers.initPageTag(self);
        
      });
      self.logOut = function () {
          $.post('/account/LogOff');
          document.location.href = '/account/login';
      }
      self.preventMeFromClosing = function (e) {
          console.log('no propagation');
          e.stopPropagation();
          return false;
      }
      self.hideTaskForm = function (e,forceHide) {
          console.log(e);
          
          if (!forceHide && e.target.tagName === 'TASKTIME') {
              return false;
          }
          
          document.getElementById('addTaskTimeForm').style.display = 'none';
          document.getElementById('addTaskTimeForm').removeEventListener('click', self.preventMeFromClosing);
          document.removeEventListener('click', self.hideTaskForm);
      };
      this.addTaskTime = function (e) {

          var theForm = document.getElementById('addTaskTimeForm');

          
          console.log(theForm.style.display);
          if (theForm.style.display == "none") {
              theForm.style.display = 'block';
              setTimeout(function () {
                  document.addEventListener('click', self.hideTaskForm);
                  theForm.addEventListener('click', self.preventMeFromClosing);
              }, 250);
              console.log(e);
              if (e.target.tagName == 'svg' || e.target.tagName == 'path') {
                  theForm.style.left = e.target.offsetParent.offsetLeft + 'px';
              } else {
                  theForm.style.left = e.target.offsetLeft + 'px';
              }
              
          } else {
              self.hideTaskForm(e,true);
          }
      };
    </script>
</side-menu>