# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery -> 

	if $('.pagination').length
		$(window).scroll ->
			url = $('.pagination .next_page').attr('href')
			if url && $(window).scrollTop() > $(document).height() - $(window).height() - 500
				$('pagination').text("Loading more instruments...")
				$.getscript(url)
			$(window).scroll()


	$('#instruments').imagesLoaded ->
		$('#instruments').masonry 
			itemSelector: ".box"
			
			$("#container").masonry
  				itemSelector: ".box"
				
				# set columnWidth a fraction of the container width
				$("#container").masonry
				columnWidth: (containerWidth) ->
	    			containerWidth / 4

	$ ->
	  $("#rental_start_on").datepicker
	    defaultDate: "+1w"
	    changeMonth: true
	    numberOfMonths: 2
	    onClose: (selectedDate) ->
	      $("#to").datepicker "option", "minDate", selectedDate

	  $("#rental_end_on").datepicker
	    defaultDate: "+1w"
	    changeMonth: true
	    numberOfMonths: 2
	    onClose: (selectedDate) ->
	      $("#from").datepicker "option", "maxDate", selectedDate

	$ ->
	  $("#slider-range-min").slider
	    range: "min"
	    value: 40
	    min: 10
	    max: 700
	    slide: (event, ui) ->
	      $("#amo	unt").val "$" + ui.value

	  $("#amount").val "$" + $("#slider-range-min").slider("value")