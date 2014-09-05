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
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
$(document).ready(function() {  
    $('.container-fluid').css('min-height', screen.height-85);
	$('.container-fluid').css('min-width', screen.width-85);
	$('#myCarousel').css('min-height', screen.height-85);
	$('#carouselimage1').css('min-height', screen.height-200);
	$('#carouselimage2').css('min-height', screen.height-200);
	$('#carouselimage3').css('min-height', screen.height-200);
});

	