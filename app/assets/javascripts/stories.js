/**
 * Created by blairanderson on 7/1/14.
 */
var StoriesController = Paloma.controller('Stories');

StoriesController.prototype.index = function () {
  $('.truncate').hide();
  $('.toggle-panel-body').on("click", function (e) {
    e.preventDefault();
    var target = $(this).attr("href");
    $("[data-href='" + target + "']").slideToggle();
  });
};

StoriesController.prototype.edit = function () {
  var handler = new MessageForm();
  handler.init()
};