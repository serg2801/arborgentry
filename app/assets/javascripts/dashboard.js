//------------- Dashboard.js -------------//
$(document).ready(function () {

    //------------- Sparklines in header stats -------------//
    $('#spark-visitors').sparkline([5, 8, 10, 8, 7, 12, 11, 6, 13, 8, 5, 8, 10, 11, 7, 12, 11, 6, 13, 8], {
        type: 'bar',
        width: '100%',
        height: '20px',
        barColor: '#dfe2e7',
        zeroAxis: false,
    });

    $('#spark-templateviews').sparkline([12, 11, 6, 13, 8, 5, 8, 10, 12, 11, 6, 13, 8, 5, 8, 10, 12, 11, 6, 13, 8, 5, 8], {
        type: 'bar',
        width: '100%',
        height: '20px',
        barColor: '#dfe2e7',
        zeroAxis: false,
    });

    $('#spark-sales').sparkline([19, 18, 20, 17, 20, 18, 22, 24, 23, 19, 18, 20, 17, 20, 18, 22, 24, 23, 19, 18, 20, 17], {
        type: 'bar',
        width: '100%',
        height: '20px',
        barColor: '#dfe2e7',
        zeroAxis: false,
    });

    //------------- Animated progressbars on tiles -------------//
    //animate bar only when reach the bottom of screen
    $('.animated-bar .progress-bar').waypoint(function (direction) {
        $(this).progressbar({display_text: 'none'});
    }, {offset: 'bottom-in-view'});

    //------------- CounTo for tiles -------------//
    $('.stats-number').countTo({
        speed: 1000,
        refreshInterval: 50
    });

    //------------- Flot charts -------------//

    //define chart colours first
    var chartColours = {
        gray: '#bac3d2',
        teal: '#43aea8',
        blue: '#60b1cc',
        red: '#df6a78',
        orange: '#cfa448',
        gray_lighter: '#e8ecf1',
        gray_light: '#777777',
        gridColor: '#bfbfbf'
    }

    //convert the object to array for flot use
    var chartColoursArr = Object.keys(chartColours).map(function (key) {
        return chartColours[key]
    });

    //generate random number for charts
    randNum = function (series) {
        return (Math.floor(Math.random() * (1 + 10 - 1) + series));
    }

    //-------------Line chart -------------//
    $(function () {
        //some data

        var d1 = [];
        var d2 = [];

        for (i = 0; i < 31; i++) {
            d1.push([new Date(Date.today().add(i).days().getTime()), i + randNum(10)]);
            d2.push([new Date(Date.today().add(i).days().getTime()), i + randNum(20)]);
        }


        var chartMinDate = d1[1][0]; //first day
        var chartMaxDate = d1[30][0];//last day

        var tickSize = [1, "day"];
        var tformat = "%d/%b";

        var options = {
            grid: {
                show: true,
                aboveData: true,
                color: chartColours.gridColor,
                labelMargin: 15,
                axisMargin: 0,
                borderWidth: 0,
                borderColor: null,
                minBorderMargin: 5,
                clickable: true,
                hoverable: true,
                autoHighlight: true,
                mouseActiveRadius: 20
            },
            series: {
                grow: {active: true},
                lines: {
                    show: true,
                    fill: false,
                    lineWidth: 2,
                    steps: false
                },
                curvedLines: {
                    apply: false,
                    active: true,
                    monotonicFit: true
                },
                points: {show: false}
            },
            legend: {
                position: "ne",
                margin: [0, -25],
                noColumns: 0,
                labelBoxBorderColor: null,
                labelFormatter: function (label, series) {
                    // just add some space to labes
                    return '&nbsp;&nbsp;' + label + ' &nbsp;&nbsp;';
                },
                width: 30,
                height: 2
            },
            yaxis: {min: 0},
            xaxis: {
                mode: "time",
                minTickSize: tickSize,
                timeformat: tformat,
                min: chartMinDate,
                max: chartMaxDate,
                tickLength: 0
            },
            colors: chartColoursArr,
            shadowSize: 1,
            tooltip: true, //activate tooltip
            tooltipOpts: {
                content: "%s : %y.0" + " $",
                shifts: {
                    x: -30,
                    y: -50
                }
            }
        };

        //$.plot($("#line-chart-payments"), [
        //	{
        //		label: "PayPal",
        //		data: d1,
        //		lines: {fillColor: chartColours.gray}
        //	},
        //	{
        //		label: "Credit Card",
        //		data: d2,
        //		lines: {fillColor: chartColours.teal}
        //	}
        //
        //], options);

    });

    //------------- Sparkline in payment received chart -------------//
    $('.spark-payments').sparkline([5, 8, 10, 8, 7, 12, 11, 6, 13, 8, 5, 8, 10, 11, 7, 12, 11, 6, 13], {
        type: 'bar',
        width: '100%',
        height: '20px',
        barColor: '#f1f3f6',
        zeroAxis: false,
    });

    //------------- User satisfaction chart -------------//
    var customerProgress = new ProgressBar.Circle('#customer-exp', {
        color: '#bec3d1',
        strokeWidth: 2,
        fill: '#e0e0e0',
        duration: 4000,
        easing: 'bounce'
    });
    customerProgress.animate(0.8);

    //------------- Montly sales goal chart -------------//
    var salesProgress = new ProgressBar.Circle('#sales-goal', {
        color: '#47a877',
        strokeWidth: 4,
        fill: '#f1fcf7',
        duration: 4000,
        easing: 'bounce'
    });
    salesProgress.animate(0.5);

    var mas_city;

    $.ajax({
        type: 'GET',
        dataType: 'JSON',
        url: '/map_city_visits',
        success: function (data) {
            mas_city = data.mas_city
            locations_map(mas_city)
        }
    });


    function locations_map(mas) {

        //------------- Last sales locations -------------//
        $('#world-map').vectorMap({
            map: 'world_mill_en',
            scaleColors: ['#f7f9fe', '#29b6d8'],
            normalizeFunction: 'polynomial',
            hoverOpacity: 0.7,
            hoverColor: false,
            focusOn: {
                x: 0.5,
                y: 0.5,
                scale: 1.0
            },
            zoomMin: 0.85,
            markerStyle: {
                initial: {
                    fill: '#df6a78',
                    stroke: '#df6a78'
                }
            },
            backgroundColor: '#fff',
            regionStyle: {
                initial: {
                    fill: '#dde1e7',
                    "fill-opacity": 1,
                    stroke: '#f7f9fe',
                    "stroke-width": 0,
                    "stroke-opacity": 0
                },
                hover: {
                    "fill-opacity": 0.8
                },
                selected: {
                    fill: 'yellow'
                }
            },
            markers:
                $.each(mas, function (index, value) {
                    value
                })
        });

    }


    //------------- New user notifications -------------//
    function capitalise(string) {
        return string.charAt(0).toUpperCase() + string.slice(1).toLowerCase();
    }

    setTimeout(function () {
        $.ajax({
            url: 'http://api.randomuser.me/',
            dataType: 'json',
            success: function (data) {
                //res = data.results[0].user;
                //$.gritter.add({
                //	title: capitalise(res.name.first) + ' ' + capitalise(res.name.last),
                //	text: 'Is come online',
                //	image: res.picture.thumbnail,
                //	close_icon: 'l-arrows-remove s16'
                //});
            }
        });
    }, 10000);

    //Weather ajax
    // function weather_install() {
    $.ajax({
        type: 'GET',
        dataType: 'JSON',
        url: '/weather',
        success: function (data) {
            weather_panel(data.first_day_icon, data.second_day_icon, data.third_day_icon);
            weather_bg(data.first_day_icon)
        }
    });
    //};


    function weather_panel(first_day_icon, second_day_icon, third_day_icon) {
        //------------- Weather panel -------------//
        var today = new Skycons({
            "color": '#51566c',
            "resizeClear": true
        });
        today.set("weather-now", first_day_icon);
        today.play();

        //second_day
        var second_day = new Skycons({
            "color": '#fff',
            "resizeClear": true
        });
        second_day.set("weather-next", second_day_icon);
        second_day.play();

        //third_day
        var third_day = new Skycons({
            "color": '#fff',
            "resizeClear": true
        });
        third_day.set("weather-next_2", third_day_icon);
        third_day.play();
    }

    function weather_bg(bg) {
        var block = $('#weather_bg');
        if (bg == 'snow') {
            block.addClass('snow');

        } else if (bg == 'rain') {
            block.addClass('rain');

        } else if (bg == 'clear-day') {
            block.addClass('clear');

        } else if (bg == 'cloudy') {
            block.addClass('cloudy');

        } else if (bg == 'sleet') {
            block.addClass('rain');

        } else if (bg == 'partly-cloudy-day') {
            block.addClass('clear');

        } else if (bg == 'clear-night') {
            block.addClass('clear-night');

        } else if (bg == 'partly-cloudy-night') {
            block.addClass('clear-night');

        } else if (bg == 'wind') {
            block.addClass('fog');

        } else if (bg == 'fog') {
            block.addClass('fog');

        } else {
            block.addClass('sunny');
        }

    }

    $(document).on('click', "#btn_f_c", function () {
        var btn = $("#btn_f_c")

        $.ajax({
            type: 'GET',
            dataType: 'JSON',
            url: '/convert_temperature',
            success: function (data) {

                if (data.temperature == 'celsius') {
                    $(".f_today").hide();
                    $(".f_second_day").hide();
                    $(".f_third_day").hide();
                    $(".c_today").toggle();
                    $(".c_second_day").toggle();
                    $(".c_third_day").toggle();
                } else {
                    $(".c_today").hide();
                    $(".c_second_day").hide();
                    $(".c_third_day").hide();
                    $(".f_today").toggle();
                    $(".f_second_day").toggle();
                    $(".f_third_day").toggle();
                }

            }
        });
    });


});