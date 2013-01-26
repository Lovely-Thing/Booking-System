# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

setHidden = () ->
  appt_date = moment($('#appt_date').val())
  theval = appt_date.format('YYYY-MM-DD') + ' ' + $('#appt_time').val()
  $('#appointment_appointment_time').val(theval)

$ ->	
  $('#appt_date').datepicker()
  if $('#appointment_appointment_time').val() != ''
    olddate = moment($('#appointment_appointment_time').val(), "YYYY-MM-DD HH:mm:ss")
    $('#appt_date').val(olddate.format("MM/DD/YYYY"))
    $('#appt_time').val(olddate.format("HH:mm"))
    
  $('#appt_date').change ->
    setHidden()

  $('#appt_time').change ->
    setHidden()
