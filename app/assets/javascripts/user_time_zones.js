/**
 * Created by blairanderson on 7/10/14.
 */

var UserTimeZonesController = Paloma.controller('UserTimeZones');

function timeZoner() {
  var tzid = Intl.DateTimeFormat().resolved.timeZone,
    cutzDiv = $("#current-user-time-zone"),
    cutz = cutzDiv.data('time-zone');

  if (tzid && cutz && tzid != cutz) {
    debugger
    cutzDiv.html("Can we update your timezone to: " + tzid + "?");
    cutzDiv.append($("<a>", {text: "YES!", "class": "button primary"}));
  }
}

UserTimeZonesController.prototype.edit = function () {
  $(".chosen-select").chosen();
//  timeZoner();
};