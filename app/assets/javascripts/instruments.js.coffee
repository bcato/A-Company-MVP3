# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery -> 
	$('#instruments').imagesLoaded ->
		$('#instruments').masonry 
			itemSelector: ".box"
			
			$("#container").masonry
  				itemSelector: ".box"
				
				# set columnWidth a fraction of the container width
				columnWidth: (containerWidth) ->
	    			containerWidth / 4

	$ ->
	  $("#from").datepicker
	    defaultDate: "+1w"
	    changeMonth: true
	    numberOfMonths: 2
	    onClose: (selectedDate) ->
	      $("#to").datepicker "option", "minDate", selectedDate

	  $("#to").datepicker
	    defaultDate: "+1w"
	    changeMonth: true
	    numberOfMonths: 2
	    onClose: (selectedDate) ->
	      $("#from").datepicker "option", "maxDate", selectedDate