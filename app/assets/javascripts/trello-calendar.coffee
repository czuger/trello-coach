$ ->
  if window.location.pathname == '/'
    data = build_calendar(
      JSON.parse( $('#tasks_data').val() )
      [0,6]
      ["#ffffff", "#ffffbf", "#d9ef8b", "#a6d96a", "#66bd63", "#1a9850", "#006837"]
      '<<Date>> : <<Count>> tasks done'
    )