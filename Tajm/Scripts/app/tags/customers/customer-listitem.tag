<customer-listitem>
  <div>
    <b onclick="{ toggleTimer }" class="{spinSlow: timerOn}" medium-icon="" entypo-icon="Stopwatch" style="fill:rgba(255,0,0,0.87);"></b>
    <b onclick="{ showInfo }" medium-icon="" entypo-icon="Info" style="fill:rgba(255,0,0,0.87);"></b>
  </div>
  <label>{customer.name}</label>
  
	<script>
    var self = this;
    self.timerOn = false;
    self.customer = opts.customer;
    self.on('mount', function(){
    helpers.initPageTag(self);
    });
    self.showInfo = function(){

    };
    self.toggleTimer = function(){
      self.timerOn = !self.timerOn;
      self.update();
    }
  </script>
</customer-listitem>