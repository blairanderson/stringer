/**
 * @summary     theDirt
 * @description handle dirty rails forms
 * @version     0.0.1
 * @file        jquery.theDirt.js
 * @author      Blair Anderson (www.github.com/blairanderson)
 * @contact     www.github.com/blairanderson
 *
 * @copyright Copyright 2014 Blair Anderson
 *
 */

/**
 *  @example
 *    // Basic initialisation
 *    $(document).ready( function {
 *      $('#example').theDirt();
 *    } );
 */

$(function () {
  var theDirt = function (options) {
    var $el = $(this),
        $selects = $el.find('select'),
        $submitButton = $el.find("input[type='submit']");

    debugger

    // rails form should be remote-true
    $el.attr('data-remote', true);

    for (var i = $selects.length - 1; i >= 0; i--) {
      var obj = $($selects[i]);
      obj.data('start', obj.val() );
      obj.addClass('disabled');
      console.log(obj.data('start'));
    }

    // on input change, submit the form
    // on input change, change form button to 'dirty'
    // on form ajax error, show error
    // on form ajax success, change to default

    // form error
    $el.ajaxError(function (e, request, settings) {
      $submitButton.val('Try Again.');
    });

    // form success
    $el.on('ajax:success', function (e, data, status, xhr) {
      var $form = $(e.currentTarget);
      $submitButton.val('Saved');
      // reset the start attributes
    });

    // when anything changes on an input, change the button to 'saving...' or 'saved' whenever it should
    $selects.change(function (e) {
      $this = $(this)
      if ($this.val() != $this.data("start")) {
        $submitButton.removeClass('disabled');
        // $el.submit();
      }
    });
  }

  theDirt.version = "0.0.1";
  // jQuery aliases
  $.fn.theDirt = theDirt;
  $.fn.theDirtSettings = theDirt.settings;
});



;(function ( $, window, document, undefined ) {
  // Create the defaults once
  var pluginName = "theDirt";

  // The actual plugin constructor
  function theDirt ( element, options ) {
    this.element = element;
    this.settings = $.extend( {}, defaults, options );
    this._defaults = defaults;
    this._name = pluginName;
    this.init();
  }

  $.extend(ajaxWizard.prototype, {
    init: function () {
      $(this.element).find('fieldset:first-child').addClass('current');
      this.eventListeners();
    },
    eventListeners: function () {
      var self = this;

      $(this.element).on('submit', function(e){
        e.preventDefault();
        self.whenCallingNextStep(this);
      });

      $(this.element).on('click', this.settings.controlSelectors.forward, function(){
        self.whenCallingNextStep(this);
      });

      $(this.element).on('click', this.settings.controlSelectors.backward, function(){
        self.backward();
      });
    },
    animate: function(from, to){
      from.hide().removeClass('current');
      to.fadeIn().addClass('current');
    }
  });

  // A really lightweight plugin wrapper around the constructor,
  // preventing against multiple instantiations
  $.fn[ pluginName ] = function ( options ) {
    this.each(function() {
      if ( !$.data( this, "plugin_" + pluginName ) ) {
        $.data( this, "plugin_" + pluginName, new theDirt( this, options ) );
      }
    });

    // chain jQuery functions
    return this;
  };

})( jQuery, window, document );