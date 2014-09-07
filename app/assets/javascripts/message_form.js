var DEBOUNCE = 500;

function MessageForm() {
    this.$el = $("article.content");
    var $form = this.$form = $('form');
    this.$formInput = $form.find('#message_content');
    this.$formSubmit = $form.find('input.button');
    this.$formTextCount = $form.find("button.length");
}

MessageForm.prototype.init = function () {
    $(".yin").find("section").attr("style", null)
    this.$formInput.hide()

    this.textLinker();
    this.textCounter();

    this.bindEvents();
};


MessageForm.prototype.bindEvents = function () {
    var self = this;
    this.$el.on('saveState', function () {
        self.throttledTextCounter();
        self.throttledTextLinker();
    });

    this.$formSubmit.click(function (e) {
        e.preventDefault();
        var $text = self.$el.text();

        self.$formInput.val($text);
        self.$form.submit();
    });
};

MessageForm.prototype.textLinker = function () {
    var autoLinked = twttr.txt.autoLink(this.$el.text());
    this.$el.html(autoLinked);
};

MessageForm.prototype.throttledTextLinker = _.debounce(MessageForm.prototype.textLinker, DEBOUNCE);

MessageForm.prototype.textCounter = function () {
    var length = twttr.txt.getTweetLength(this.$el.text());
    var lengthRemaining = 140 - length;
    this.$formTextCount.text(lengthRemaining);

    var $actions = this.$form.find('.actions');
    $actions.removeClass('danger disabled');
    if (lengthRemaining < 20) {
        $actions.addClass('danger')
    }

    if (lengthRemaining < 0) {
        $actions.addClass('disabled')
    }
};

MessageForm.prototype.throttledTextCounter = _.debounce(MessageForm.prototype.textCounter, DEBOUNCE);

