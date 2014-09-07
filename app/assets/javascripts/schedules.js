/**
 * Created by blairanderson on 7/6/14.
 */


var SchedulesController = Paloma.controller('Schedules');

//http://codepen.io/daneden/pen/JFxAw

SchedulesController.prototype.index = function () {
//  $('form').theDirt()
  $('input[type="checkbox"]').on('change', function (e) {
      e.preventDefault()
      var $this = $(this);
      var url = $this.data('path');
      var day = $this.data('day');
      url += this.checked ? "&active=true" : "&active=false";

      $.ajax({
        type: "POST",
        url: url,
        data:  {_method:'PUT', schedule: {active: this.checked, toggle: day}},
        dataType: 'json',
        success: function (msg) {
          debugger
        },
        error: function(msg){
          debugger
          // untoggle the item
        }
      });
    }
  )
  ;
}
;