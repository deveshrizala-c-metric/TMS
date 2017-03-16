# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:request-end', ->
  if tinyMCE
    tinyMCE.remove()
  return

$(document).on "turbolinks:load", ->
  locationName = window.location.href.split('/')[3].replace('#','')
  if typeof window.location.href.split('/')[4] != 'undefined'
    secondUrl = window.location.href.split('/')[4].replace('#','')

  if locationName == ''
    $('#home').addClass 'active'
  else
     if locationName == 'users' and (secondUrl == 'edit' or secondUrl == 'sign_out' or secondUrl == 'sign_in')
       $('#user_profile').addClass 'active'
     else
       $('#' + locationName).addClass 'active'

  $('.tag-tooltip').tooltip()

  if $('#myTable').length > 0 and !$('#myTable_wrapper').length > 0
    $('#myTable').dataTable 'columnDefs': [ {
      'orderable': false
      'targets': -1
    } ]

  $ ->
    validator = $('#new_ticket').submit(->
      tinyMCE.triggerSave()
      return
    ).validate(
      ignore: ''
      rules:
        issue_details: 'required')
    return

  $.validator.addMethod 'regx', ((value, element, regexpr) ->
    regexpr.test value
  ), 'Please enter a valid email address.'

  $('.clientside_validation').validate rules:
    jQuery.validator.addClassRules
      require_validation:
        required: true
      length_validation:
        minlength: 2
        maxlength: 20
      email_validation:
        regx: /^([A-z])+((\.|\-)?([A-z]|[0-9])+)*@{1}[A-z]+(\-?[A-z])*(\.[A-z]+)+$/
      password_validation:
        minlength: 6
        maxlength: 30
      confirm_password_validation: {
        equalTo: "#user_password"
        }
      phone_validation:
        digits: true
        maxlength: 15
  return