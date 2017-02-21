# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:request-end', ->
  if tinyMCE
    tinyMCE.remove()
  return

$(document).on "turbolinks:load", ->

  if window.location.href.split('/')[3] == ''
    $('#home').addClass 'active'
  else
    if window.location.href.split('/')[3] == 'users' and (window.location.href.split('/')[4] == 'edit' or window.location.href.split('/')[4] == 'sign_out' or window.location.href.split('/')[4] == 'sign_in')
      $('#user_profile').addClass 'active'
    else
      $('#' + window.location.href.split('/')[3]).addClass 'active'

  $('.tag-tooltip').tooltip()

  if $('#myTable').length > 0 and !$('#myTable_wrapper').length > 0
    $('#myTable').dataTable 'columnDefs': [ {
      'orderable': false
      'targets': -1
    } ]