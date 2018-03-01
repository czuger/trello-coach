# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  if window.location.pathname == '/git_summary/show'
    all_git_data = JSON.parse( $('#git_data').val() )
    for git_key, git_data of all_git_data
      build_calendar(
        "##{git_key}"
        git_data
        [0, 14]
        ["#ffffff", "#ffffbf", "#d9ef8b", "#a6d96a", "#66bd63", "#1a9850", "#006837"]
        '<<Date>> : <<Count>> commits'
      )
    null