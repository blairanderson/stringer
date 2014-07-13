var MessagesController = Paloma.controller('Messages');

MessagesController.prototype.index = function () {
    $('.message p.lead').each(function(){
        var $this = $(this);
        var autoLinked = twttr.txt.autoLink($this.text());
        $this.html(autoLinked);
    });
};

MessagesController.prototype.new = function () {
    var handler = new MessageForm();
    handler.init()
};

MessagesController.prototype.edit = function () {
    var handler = new MessageForm();
    handler.init()
};

