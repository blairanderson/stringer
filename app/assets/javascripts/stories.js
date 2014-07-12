/**
 * Created by blairanderson on 7/1/14.
 */
var StoriesController = Paloma.controller('Stories');

StoriesController.prototype.index = function () {
    $('#myModal').on('hidden', function () {
        $(this).removeData('modal');
    });
};

StoriesController.prototype.edit = function () {
    debugger
    var _message_change = function _message_change() {
        var $rawText = $(this).val();
        console.log('raw text', $rawText);
        var $autoLinked = twttr.txt.autoLink($rawText);
        console.log($autoLinked);
    };
    var messageChange = _.debounce(_message_change, 1000);

    var message_key_up = function messageKeyUp() {
        var $text = $(this),
            $form = $text.parents('form'),
            $targetLabel = $form.find('button.length'),
            $actions = $form.find('.actions'),
            length = twttr.txt.getTweetLength($text.val()),
            lengthRemaining = 140 - length;

        $targetLabel.text(lengthRemaining);
        $actions.removeClass('danger disabled');
        if (lengthRemaining < 20) {
            $actions.addClass('danger')
        }

        if (lengthRemaining < 0) {
            $actions.addClass('disabled')
        }
    };
    var messageKeyUp = _.throttle(message_key_up, 100);

    $(document).on('keyup', "article.content", messageKeyUp);

};





