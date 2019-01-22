// From : https://bl.ocks.org/mbostock/4063318

// Build a calendar
// json_data is an array of hash. Each hash is of the form { "Date" : "YYYY-MM-DD", "Count" : <number> }
// range is an array : the range of your numbers in "Count". Exemple : [ 0, 6 ]
// colors is an array of colors associated to your domain (one color per interval 7 in this example). Exemple : ["#ffffff", "#ffffbf", "#d9ef8b", "#a6d96a", "#66bd63", "#1a9850", "#006837"]
// hoover_string is a string with two replaceable string <<Date>> and <<Count>> like '<<Date>> : <<Count>> tasks done'
function build_calendar( calendar_id, calendar_data, range, colors, hoover_string ) {

    // console.log( 'Loading D3 graph' )

    var width = 960,
        height = 136,
        cellSize = 17;

    var formatPercent = d3.format(".1%");

    var color = d3.scaleQuantize()
        .domain(range)
        .range(colors);

    // console.log( d3.select("#trello-calendar") );

    var svg = d3.select(calendar_id)
        .selectAll("svg")
        .data(d3.range(2019, 2020))
        .enter().append("svg")
        .attr("width", width)
        .attr("height", height)
        .append("g")
        .attr("transform", "translate(" + ((width - cellSize * 53) / 2) + "," + (height - cellSize * 7 - 1) + ")");

    // console.log( svg )

    svg.append("text")
        .attr("transform", "translate(-6," + cellSize * 3.5 + ")rotate(-90)")
        .attr("font-family", "sans-serif")
        .attr("font-size", 10)
        .attr("text-anchor", "middle")
        .text(function(d) { return d; });

    var rect = svg.append("g")
        .attr("fill", "none")
        .attr("stroke", "#ccc")
        .selectAll("rect")
        .data(function(d) { return d3.timeDays(new Date(d, 0, 1), new Date(d + 1, 0, 1)); })
        .enter().append("rect")
        .attr("width", cellSize)
        .attr("height", cellSize)
        .attr("x", function(d) { return d3.timeWeek.count(d3.timeYear(d), d) * cellSize; })
        .attr("y", function(d) { return d.getDay() * cellSize; })
        .datum(d3.timeFormat("%Y-%m-%d"));

    svg.append("g")
        .attr("fill", "none")
        .attr("stroke", "#000")
        .selectAll("path")
        .data(function(d) { return d3.timeMonths(new Date(d, 0, 1), new Date(d + 1, 0, 1)); })
        .enter().append("path")
        .attr("d", pathMonth);

    var data = d3.nest()
        .key(function(d) { return d.Date; })
        .rollup(function(d) { return d[0].Count; })
        .object(calendar_data);

    rect.filter(function(d) { return d in data; })
        .attr("fill", function(d) { return color(data[d]); })
        .append("title")
        .text(function(d) {
            outp_string = hoover_string.replace( '<<Date>>', d );
            outp_string = outp_string.replace( '<<Count>>', data[d].toString() );
            return outp_string;
        });

    function pathMonth(t0) {
        var t1 = new Date(t0.getFullYear(), t0.getMonth() + 1, 0),
            d0 = t0.getDay(), w0 = d3.timeWeek.count(d3.timeYear(t0), t0),
            d1 = t1.getDay(), w1 = d3.timeWeek.count(d3.timeYear(t1), t1);
        return "M" + (w0 + 1) * cellSize + "," + d0 * cellSize
            + "H" + w0 * cellSize + "V" + 7 * cellSize
            + "H" + w1 * cellSize + "V" + (d1 + 1) * cellSize
            + "H" + (w1 + 1) * cellSize + "V" + 0
            + "H" + (w0 + 1) * cellSize + "Z";
    }
};