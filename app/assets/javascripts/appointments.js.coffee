# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$('#appointment_appointment_time').datetimepicker( 
		showSecond: false,
		timeFormat: 'h:mm tt', 
		stepMinute: 15,
		hourMin: 8,
		hourMax: 18,
		controlType: 'select',
		minDate: Date.now()
	 )  

	