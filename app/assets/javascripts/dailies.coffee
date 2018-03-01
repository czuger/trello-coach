# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  if window.location.pathname == '/dailies/show'
    data = build_calendar(
      '#blender-calendar'
      JSON.parse( $('#blender_data').val() )
      [0,1]
      ["#ffffff", "#d9ef8b"]
      '<<Date>> : <<Count>>'
    )