// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.masonry.min.js
//= require jquery.ui.datepicker
//= require jquery.ui.slider
//= require twitter/bootstrap
//= require bootstrap-dropdown.js
//= require bootstrap
//= require bootstrap-alert
//= require_tree .

jQuery -> 
	$('.dropdown-toggle').dropdown()
	$("input[type=file]").filestyle
		image: "guitar_logo.png"
		imageheight: 22
		imagewidth: 82
		width: 250

