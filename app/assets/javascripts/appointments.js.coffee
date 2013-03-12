# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

clearTotal = () ->
  $('#appointment_price').html "0"

clearStylist = () ->
  $('#appointment_employee_id').val ''
  $('#stylist_name').html ''

# this sets the combined date/time into a hidden field
# because Rails on the backend expects a specific format
setHidden = () ->
  appt_date = moment $('#appt_date').val()
  theval = appt_date.format('YYYY-MM-DD') + ' ' + $('#appt_time').val()
  $('#appointment_appointment_time').val theval

# this sets the action that happens when a Services checkbox is toggled
setServicesAction = () ->
  $('#salon_services input:checkbox').change ->
    sel = '#service_' + $(this).val()
    amt = parseInt $(sel).html()
    tot = parseInt $('#appointment_price').html()
    if !$(this).is(":checked")
      amt *= -1
    tot += amt
    $('#appointment_price').html(tot)

getSalons = () ->
  $.getJSON '/salons.json', (data) ->
    salons = ''
    $.each data, (i, item) ->
      salons += "<div id='#{item.id}' name='#{item.name}' class='salon'><h1>#{item.name}</h1>#{item.address}<br/>#{item.city}, #{item.state} #{item.zip}</div>"
    salons += "<div id='salon_footer'>Click a salon to select</div>"
    $(salons).appendTo('#salon_div')
    $('.salon').click -> 
      $('#salon_name').html $(this).attr('name')
      $('#salon_id').val($(this).attr('id')).change()
      # clear out the stylist info...
      clearStylist()
      $('#salon_div').fadeOut 500
      $('#stylist_div').fadeIn 300

getStylists = () ->
  # must clear the total in case they had any
  # services selected from the previous salon
  clearTotal()
  salon_id = $('#salon_id').val()
  $('#stylist_div').html '<h1>Select a stylist</h1>'
  $.getJSON "/salons/#{salon_id}/stylists.json", (data) ->
    st = data[0].stylists
    em = data[0].employees
    stylists = ''
    $.each st, (i, item) ->
      stylists += "<div id='#{em[i].id}' name='#{item.name}' class='stylist2'>
        <img class='stylist_image
          ' src='#{item.image['thumb'].url}'>
        <b>#{item.name}</b><br/>
        </div>"
    stylists += "<div id='stylist_footer'>Click on a stylist to select</div>"
    $(stylists).appendTo('#stylist_div')
    $('.stylist2').click ->
      $('#appointment_employee_id').val $(this).attr('id')
      $('#stylist_name').html $(this).attr('name')
      $('#stylist_div').fadeOut 500
      $('#services_div').fadeIn 300

getServices = () ->
  $('#salon_services').html ''
  salon_id = $('#salon_id').val()
  $.getJSON "/salons/#{salon_id}/services.json", (data) ->
    services = '<table><tr><th>&nbsp;</th><th style="text-align: left">Service</th><th style="text-align: right">Price</th>'

    $.each data, (i, item) ->
      services += "<tr><td><input type='checkbox' name='service[]' id='service[]' value='#{item.id}'></td><td id='service_#{item.id}_name'>#{item.name}</td><td id='service_#{item.id}' style='text-align: right'>#{item.price}</td></tr>"

    services += '</table>'
    $(services).appendTo('#salon_services')
    setServicesAction()

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

  # if we already have an employee id, this is 'edit' mode
  # so let's don't get the salons and hide the salon div
  if ($('#appointment_employee_id').val() == '') 
    getSalons() 
  else 
    $('#salon_div').hide()
    $('#change_salon').hide()
    $('#change_stylist').hide()
  
  # when you change the salon, get the salon's stylists and services
  # and then show the stylist form
  $('#salon_id').change ->
    getStylists()
    getServices()
    $('#stylist_form').show()

  # when you select a stylist, hide the stylist form and show the services
  $('#stylist_form').change ->
    $('#stylist_name').html $('#stylist_list option:selected').html()
    $('#stylist_form').fadeOut 500
    $('#services_form').show()

  # initially, hide the stylists and services
  $('#stylist_div').hide()
  $('#services_form').hide()
  $('#services_div').hide()

  $('#services_btn').click ->
    lst = ''
    $('input:checkbox:checked').each ->
      itm = '#service_' + $(this).val() + '_name'
      lst += $(itm).html() + "<br />"
      
    $('#services_list').html lst
    $('#services_div').fadeOut 500

  $('#change_salon').click ->
    $('#salon_div').fadeIn 300

  $('#change_stylist').click ->
    $('#stylist_div').fadeIn 300

  $('#change_services').click ->
    $('#services_div').fadeIn 300

  setServicesAction()



