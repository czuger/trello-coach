$ ->
  if window.location.pathname == '/' || window.location.pathname == '/tasks_records/show'
    data = build_calendar(
      '#trello-calendar'
      JSON.parse( $('#tasks_data').val() )
      [0,6]
      ["#ffffff", "#ffffbf", "#d9ef8b", "#a6d96a", "#66bd63", "#1a9850", "#006837"]
      '<<Date>> : <<Count>> tasks done'
    )