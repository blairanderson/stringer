var MessagesController = Paloma.controller('Messages');

var _message_change = function _message_change() {
    var $rawText = $(this).val();
    console.log('raw text', $rawText);
    var $autoLinked = twttr.txt.autoLink($rawText);
    console.log($autoLinked);
};
var messageChange = _.debounce(_message_change, 1500);

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
var messageKeyUp = _.debounce(message_key_up, 200);

MessagesController.prototype.new = function () {
    var $form = $("form#new_message");
    $form.on('keyup', "#message_content", messageKeyUp);
    $form.on('blur', "#message_content", messageChange);
};

MessagesController.prototype.index = function () {
    var $form = $("form#new_message");
    $form.on('keyup', "#message_content", messageKeyUp);
    $form.on('blur', "#message_content", messageChange);
};