# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:request-end', ->
  if tinyMCE
    tinyMCE.remove()
  return

fnPriority = (a) ->
  if a == 'High'
    return 1
  else if a == 'Medium'
    return 2
  else if a == 'Low'
    return 3
  4

jQuery.fn.dataTableExt.oSort['priority-asc'] = (a, b) ->
  x = fnPriority(a)
  y = fnPriority(b)
  if x < y then -1 else if x > y then 1 else 0

jQuery.fn.dataTableExt.oSort['priority-desc'] = (a, b) ->
  x = fnPriority(a)
  y = fnPriority(b)
  if x < y then 1 else if x > y then -1 else 0


fnData_Table = (activeTab) ->
  $('#myTable3').dataTable().fnDestroy();
  if $('#myTable3').length > 0 and !$('#myTable_wrapper').length > 0
    numCols = $('#myTable3 thead th').length;
    $('#myTable3').dataTable
      'columnDefs': [ {
          'orderable': false
          'targets': -1
        },
        {
          sType: 'priority'
          targets: 3
        },
        {
          type: 'date-uk'
          targets: -2
        } ]
      "aaSorting": [[ 3, "asc" ]]
      ajax:
        url: 'tickets.json'
        data: { activetab: activeTab }
        'dataSrc': (json) ->
          i = 0
          ien = json.data.length
          while i < ien
            json.data[i][numCols-1] = "<a href='tickets/#{json.data[i][0]}' data-toggle='tooltip' data-placement='bottom' title='Show'><i class='glyphicon glyphicon-eye-open'></i>
      </a>  <a href='tickets/#{json.data[i][0]}' data-toggle='tooltip' data-placement='bottom' title='Delete' data-method='delete' data-confirm='Are you sure you want to delete this ticket ?''><i class='glyphicon glyphicon-remove'></i></a>"
            i++
          json.data

  $('#myTable4').dataTable().fnDestroy();
  if $('#myTable4').length > 0 and !$('#myTable_wrapper').length > 0
    numCols2 = $('#myTable4 thead th').length;
    $('#myTable4').dataTable
      'columnDefs': [ {
          'orderable': false
          'targets': -1
        },
        {
          sType: 'priority'
          targets: 3
        },
        {
          type: 'date-uk'
          targets: -2
        } ]
      "aaSorting": [[ 3, "asc" ]]
      ajax:
        url: 'deleted.json'
        data: { activetab: activeTab }
        'dataSrc': (json) ->
          i = 0
          ien = json.data.length
          while i < ien
            json.data[i][numCols2-1] = "<a href='#{json.data[i][0]}/restore' data-toggle='tooltip' data-placement='bottom' title='Restore'><i class='glyphicon glyphicon-repeat'></i>
      </a>"
            i++
          json.data

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
    $('#myTable').dataTable
      'columnDefs': [ {
          'orderable': false
          'targets': -1
        },
        {
          type: 'date-uk'
          targets: -2
        } ]
      "aaSorting": [[ 3 , "asc" ]]

  if $('#myTable2').length > 0 and !$('#myTable_wrapper').length > 0
    $('#myTable2').dataTable
      'columnDefs': [ {
          'orderable': false
          'targets': -1
        },
        {
          type: 'date-uk'
          targets: -2
        } ]
      "aaSorting": [[ 2 , "asc" ]]

  $('#myTabs a').click (e) ->
    e.preventDefault()
    $(this).tab 'show'
    return

  fnData_Table("open")

  $ ->
    $('a[data-toggle = "tab"]').on 'shown.bs.tab', (e) ->
      # Get the name of active tab
      activeTab = $(e.target).text()
      fnData_Table(activeTab)
      return
    return

  $ ->
    validator = $('#new_ticket').submit(->
      tinyMCE.triggerSave()
      return
    ).validate(
      ignore: ''
      rules:
        issue_details: 'required'
      errorPlacement: (label, element) ->
        # position error label after generated textarea
        if element.is('textarea')
          label.insertAfter element
        else if element.attr('id') == 'ticket_image'
           label.insertAfter ".file-input-new"
        else
          label.insertAfter element
        return
      )
    return

  $.validator.addMethod 'regx', ((value, element, regexpr) ->
    regexpr.test value
  ), 'Please enter a valid email address.'

  $.validator.addMethod 'filesize', ((value, element, param) ->
    @optional(element) or element.files[0].size <= param
  ), 'File size must be less than 5mb'

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
        maxlength: 15
      confirm_password_validation: {
        equalTo: "#user_password"
        }
      phone_validation:
        digits: true
        maxlength: 15
      image_validation:
        extension: "jpg|jpeg|png"
        filesize: 5242880
  return