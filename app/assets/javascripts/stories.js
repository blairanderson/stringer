/**
 * Created by blairanderson on 7/1/14.
 */
var StoriesController = Paloma.controller('Stories');

StoriesController.prototype.index = function () {
    $('#myModal').on('hidden', function () {
        $(this).removeData('modal');
    });
};

var _message_change = function _message_change() {
    var $textArea = $("article.content"),
        autoLinked = twttr.txt.autoLink($textArea.text());
    $textArea.html(autoLinked);
};

var messageChange = _.debounce(_message_change, 5000);

var message_key_up = function messageKeyUp() {
    var $textArea = $("article.content"),
        $text = $textArea.text(),
        $form = $('form'),
        $targetLabel = $form.find('button.length'),
        $actions = $form.find('.actions'),
        length = twttr.txt.getTweetLength($text),
        lengthRemaining = 140 - length;

    $targetLabel.text(lengthRemaining);
    $actions.removeClass('danger disabled');
    if (lengthRemaining < 20) {
        $actions.addClass('danger')
    }

    if (lengthRemaining < 0) {
        $actions.addClass('disabled')
    }
    messageChange()
};
var messageKeyUp = _.debounce(message_key_up, 100);


StoriesController.prototype.edit = function () {
    _message_change();
    $("article.content").on('saveState', messageKeyUp);
    $form = $("form");

    $('input.button').click(function (e) {
        e.preventDefault();
        var $textArea = $("article.content"),
            $text = $textArea.text();

        $target = $form.find("input.hidden#message_content");
        $target.val($text)
        $form.submit()
    });
};