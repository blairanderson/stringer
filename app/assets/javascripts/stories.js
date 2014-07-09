/**
 * Created by blairanderson on 7/1/14.
 */
var StoriesController = Paloma.controller('Stories');

StoriesController.prototype.index = function () {
    $('#myModal').on('hidden', function () {
        $(this).removeData('modal');
    });
};