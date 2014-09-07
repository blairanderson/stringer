/**
 * Created by blairanderson on 7/6/14.
 */


var SchedulesController = Paloma.controller('Schedules');

//http://codepen.io/daneden/pen/JFxAw

function post(args) {
  return $.ajax({
    type: "POST",
    url: args.url,
    data: args.data,
    dataType: 'json'
  });
}

SchedulesController.prototype.index = function () {
  $('input[type="checkbox"]').on('change', function (e) {
    e.preventDefault();

    var $this = $(this),
      url = $this.data('path'),
      day = $this.data('day');

    post({
      url: url,
      data: {_method: 'PUT', schedule: {active: this.checked, toggle: day}}
    });
  });

  $('select.time').on('change', function (e) {
    var $form = $(this.form);

    var attrs = {};
    $form.serializeArray().forEach(function (el) {
      attrs[el.name] = el.value;
    });

    console.log("attrs", attrs);

    $form.submit();

    // TODO: convert the dates to UTC before submitting... 
  });
};