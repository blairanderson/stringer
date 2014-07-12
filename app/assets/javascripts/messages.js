var MessagesController = Paloma.controller('Messages');

MessagesController.prototype.new = function () {
    var handler = new MessageForm();
    handler.init()
};

MessagesController.prototype.edit = function () {
    var handler = new MessageForm();
    handler.init()
};

