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
 *
 *  @example
 *    // Initialisation with configuration options - in this case, Green
 *    $(document).ready( function {
	 *      $('#example').theDirt( {"color": 'green'} );
	 *    } );
 */

$(function(){
  var now = Date.now || function() { return new Date().getTime(); };

  var throttle = function(func, wait, options) {
    var context, args, result;
    var timeout = null;
    var previous = 0;
    options || (options = {});
    var later = function() {
      previous = options.leading === false ? 0 : now();
      timeout = null;
      result = func.apply(context, args);
      context = args = null;
    };
    return function() {
      var now = now();
      if (!previous && options.leading === false) previous = now;
      var remaining = wait - (now - previous);
      context = this;
      args = arguments;
      if (remaining <= 0) {
        clearTimeout(timeout);
        timeout = null;
        previous = now;
        result = func.apply(context, args);
        context = args = null;
      } else if (!timeout && options.trailing !== false) {
        timeout = setTimeout(later, remaining);
      }
      return result;
    };
  };


  var theDirt = function( options ){
    $el = $(this);

    $el.attr('data-remote', true)

    // form error
    $el.ajaxError(function(e, request, settings) {
      var $form = $(e.currentTarget),
        $textarea = $form.find('textarea');
      $form.addClass('active.error');
      $form.find("input[type='submit']").val('Not Saved... Try Again...');
      $textarea.attr('data-start', $textarea.val() );
    });

    // form success
    $el.bind('ajax:success', function(e, data, status, xhr){
      var $form = $(e.currentTarget),
        $textarea = $form.find('textarea');
      $form.removeClass('active');
      $form.removeClass('error');
      $form.find("input[type='submit']").val('Saved');
      $textarea.attr('data-start', $textarea.val() );
    });

    // store a copy of the current content
    var $textfields = $('textarea');

    for (var i = $textfields.length - 1; i >= 0; i--) {
      var $textarea = $( $textfields[i] );
      $textarea.attr('data-start', $textarea.val() );
    };

    // when anything changes on an input, change the button to 'saving...' or 'saved' whenever it should
    $textfields.bind('input propertychange', function(e) {
      var $textarea = $( e.currentTarget );
      var $form = $textarea.closest('form');
      if( $textarea.val() != $textarea.data("start") ){
        $form.addClass('active');
        $form.find("input[type='submit']").val('Saving...');
      } else {
        $form.removeClass('active');
        $form.find("input[type='submit']").val('Saved');
      }
    });

    // when a user starts typing, call the timer to save
    $('textarea').keyup(throttle(function(e){
      var $textarea = $(e.currentTarget);
      if( $textarea.val() != $textarea.data("start") ){
        $textarea.closest('form').submit();
      }
    }));

    //  when a suer leave a text box, save the data
    $('textarea').blur(function(e) {
      var $textarea = $(e.currentTarget);
      if( $textarea.val() != $textarea.data("start") ){
        $textarea.closest('form').submit();
      }
    });
  };

  theDirt.version = "0.0.1";
  // jQuery aliases
  $.fn.theDirt = theDirt;
  $.fn.TheDirt = theDirt;
  $.fn.theDirtSettings = theDirt.settings;
})
