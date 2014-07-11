// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require paloma
//= require lodash
//= require jquery
//= require jquery_ujs
//= require thedirt/jquery.theDirt
//= require bootstrap
//= require chosen-jquery
//= require twitter-text
//= require moment
//= require alerts
//= require_tree .


$(document).on('page:restore', function () {
    // Manually evaluates the appended script tag.
    Paloma.executeHook();
});

$(document).ready(function () {});