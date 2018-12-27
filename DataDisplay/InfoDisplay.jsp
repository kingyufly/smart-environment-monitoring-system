<%--
  Created by IntelliJ IDEA.
  User: Wang Yufei
  Date: 2018/2/22
  Time: 18:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>
        Detial Information
    </title>
    <meta charset="utf-8">

    <script src="js/echarts.js"></script>
    <script type="text/javascript"
            src="js/jquery-3.3.1.js"></script>

</head>

<body>
<center>
    <div id="locationInfo">
        <table border="1">
            <tr>
                <th>Client ID</th>
                <th>Device Type</th>
                <th>Description</th>
                <th>Longitude</th>
                <th>Latitude</th>
                <th>Location</th>
            </tr>
            <tr>
                <td><%out.print(session.getAttribute("client_id"));%></td>
                <td><%out.print(session.getAttribute("device_type"));%></td>
                <td><%out.print(session.getAttribute("description"));%></td>
                <td><%out.print(session.getAttribute("longitude"));%></td>
                <td><%out.print(session.getAttribute("latitude"));%></td>
                <td><%out.print(session.getAttribute("location"));%></td>
            </tr>
        </table>
    </div>
    <div id="realTimeData">
        <table border="1">
            <tr>
                <th>Time</th>
                <th>Temperature(°C)</th>
                <th>Humidity(%)</th>
                <th>PM2.5(ppm)</th>
                <th>CO(ppm)</th>
            </tr>
            <tr>
                <td id="Time"></td>
                <td id="T"></td>
                <td id="H"></td>
                <td id="PM"></td>
                <td id="CO"></td>
            </tr>
        </table>
    </div>
    <div>
        <table border="1">
            <tr>
                <th>Dress Advice</th>
                <th>Health Advice</th>
            </tr>
            <tr>
                <td id="advice1"></td>
                <td id="advice2"></td>
            </tr>
        </table>
    </div>
</center>
<div id="HourTH" style="width: 100%; height: 50%;"></div>
<br>
<div id="HourPM" style="width: 100%; height: 50%;"></div>
<br>
<div id="HourCO" style="width: 100%; height: 50%;"></div>
<br>
<div id="DayT" style="width: 100%; height: 50%;"></div>
<br>
<div id="DayH" style="width: 100%; height: 50%;"></div>
<br>
<div id="DayPM" style="width: 100%; height: 50%;"></div>
<br>
<div id="DayCO" style="width: 100%; height: 50%;"></div>

<script type="text/javascript">
    function HourTHData() {
        var myChart = echarts.init(document.getElementById('HourTH'));
        var url = '${pageContext.request.contextPath}/GetHourTHServlet';
        $.getJSON(url).done(function (json) {

            tData = json.tData;
            hData = json.hData;
            timeData = json.timeData;

            var option = {
                // color: ['#ffffff'],
                title: {
                    text: 'Hourly Average Value of Temperature and Humidity',
                    subtext: 'Environment Info System',
                    x: 'center',
                    align: 'right'
                },
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'cross',
                        animation: false,
                        label: {
                            backgroundColor: '#505765'
                        }
                    }
                },
                legend: {
                    data: ['Temperature', 'Humidity'],
                    x: 'left'
                },
                dataZoom: [
                    {
                        show: true,
                        realtime: true,
                        start: 86,
                        end: 100
                    },
                    {
                        type: 'inside',
                        realtime: true,
                        start: 86,
                        end: 100
                    }
                ],
                xAxis: {
                    data: timeData
                },
                yAxis: [
                    {
                        type: 'value',
                        name: 'Temperature',
                        // min: 0,
                        // max: 250,
                        // interval: 50,
                        axisLabel: {
                            formatter: '{value} °C'
                        }
                    },
                    {
                        type: 'value',
                        name: 'Humidity',
                        // min: 0,
                        // max: 25,
                        // interval: 5,
                        axisLabel: {
                            formatter: '{value} %'
                        }
                    }
                ],
                series: [
                    {
                        name: 'Temperature',
                        type: 'line',
                        itemStyle: {
                            normal: {
                                color: '#ff0000'
                            }
                        },
                        data: tData
                    }, {
                        name: 'Humidity',
                        type: 'bar',
                        itemStyle: {
                            normal: {
                                color: '#00bfff'
                            }
                        },
                        yAxisIndex: 1,
                        data: hData
                    }
                ],
                toolbox: {
                    show: true,
                    feature: {
                        mark: {
                            show: true
                        },
                        dataView: {
                            show: true,
                            readOnly: false
                        },
                        magicType: {
                            show: true,
                            type: ['line', 'bar']
                        },
                        restore: {
                            show: true
                        },
                        saveAsImage: {
                            show: true
                        }
                    }
                },
            }
            myChart.setOption(option);
        })
    }

    function HourPMData() {
        var myChart = echarts.init(document.getElementById('HourPM'));
        var url = '${pageContext.request.contextPath}/GetHourPMServlet';
        $.getJSON(url).done(function (json) {

            pmData = json.pmData;
            timeData = json.timeData;

            var option = {
                // color: ['#ffffff'],
                title: {
                    text: 'Hourly Average Value of PM2.5',
                    subtext: 'Environment Info System',
                    x: 'center',
                    align: 'right'
                },
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'cross',
                        animation: false,
                        label: {
                            backgroundColor: '#505765'
                        }
                    }
                },
                legend: {
                    data: ['PM2.5'],
                    x: 'left'
                },
                dataZoom: [
                    {
                        show: true,
                        realtime: true,
                        start: 86,
                        end: 100
                    },
                    {
                        type: 'inside',
                        realtime: true,
                        start: 86,
                        end: 100
                    }
                ],
                xAxis: {
                    data: timeData
                },
                yAxis: [
                    {
                        type: 'value',
                        name: 'PM2.5',
                        splitLine: {
                            show: false
                        },
                        // min: 0,
                        // max: 500,
                        // interval: 50,
                        axisLabel: {
                            formatter: '{value}'
                        }
                    }
                ],
                visualMap: {
                    top: 20,
                    right: 10,
                    pieces: [{
                        gt: 0,
                        lte: 80,
                        color: '#0000ff'
                    }, {
                        gt: 80,
                        lte: 160,
                        color: '#096'
                    }, {
                        gt: 160,
                        lte: 240,
                        color: '#ffde33'
                    }, {
                        gt: 240,
                        lte: 320,
                        color: '#ff9933'
                    }, {
                        gt: 320,
                        color: '#cc0033'
                    }],
                    outOfRange: {
                        color: '#999'
                    }
                },
                series: [
                    {
                        name: 'PM2.5',
                        type: 'line',
                        data: pmData,
                        markLine: {
                            silent: true,
                            data: [{
                                yAxis: 80
                            }, {
                                yAxis: 160
                            }, {
                                yAxis: 240
                            }, {
                                yAxis: 320
                            }]
                        }
                    }
                ],
                toolbox: {
                    show: true,
                    feature: {
                        mark: {
                            show: true
                        },
                        dataView: {
                            show: true,
                            readOnly: false
                        },
                        magicType: {
                            show: true,
                            type: ['line']
                        },
                        restore: {
                            show: true
                        },
                        saveAsImage: {
                            show: true
                        }
                    }
                },
            }
            myChart.setOption(option);
        })
    }

    function HourCOData() {
        var myChart = echarts.init(document.getElementById('HourCO'));
        var url = '${pageContext.request.contextPath}/GetHourCOServlet';
        $.getJSON(url).done(function (json) {

            coData = json.coData;
            timeData = json.timeData;

            var option = {
                // color: ['#ffffff'],
                title: {
                    text: 'Hourly Average Value of CO',
                    subtext: 'Environment Info System',
                    x: 'center',
                    align: 'right'
                },
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'cross',
                        animation: false,
                        label: {
                            backgroundColor: '#505765'
                        }
                    }
                },
                legend: {
                    data: ['CO'],
                    x: 'left'
                },
                dataZoom: [
                    {
                        show: true,
                        realtime: true,
                        start: 86,
                        end: 100
                    },
                    {
                        type: 'inside',
                        realtime: true,
                        start: 86,
                        end: 100
                    }
                ],
                xAxis: {
                    data: timeData
                },
                yAxis: [
                    {
                        type: 'value',
                        name: 'CO',
                        splitLine: {
                            show: false
                        },
                        // min: 0,
                        // max: 250,
                        // interval: 50,
                        axisLabel: {
                            formatter: '{value} ppm'
                        }
                    }
                ],
                visualMap: {
                    top: 20,
                    right: 10,
                    pieces: [{
                        gt: 0,
                        lte: 120,
                        color: '#096'
                    }, {
                        gt: 120,
                        lte: 180,
                        color: '#ff9933'
                    }, {
                        gt: 180,
                        color: '#cc0033'
                    }],
                    outOfRange: {
                        color: '#999'
                    }
                },
                series: [
                    {
                        name: 'CO',
                        type: 'line',
                        data: coData,
                        markLine: {
                            silent: true,
                            data: [{
                                yAxis: 30
                            }, {
                                yAxis: 100
                            }]
                        }
                    }
                ],
                toolbox: {
                    show: true,
                    feature: {
                        mark: {
                            show: true
                        },
                        dataView: {
                            show: true,
                            readOnly: false
                        },
                        magicType: {
                            show: true,
                            type: ['line']
                        },
                        restore: {
                            show: true
                        },
                        saveAsImage: {
                            show: true
                        }
                    }
                },
            }
            myChart.setOption(option);
        })
    }

    function DayTData() {
        var myChart = echarts.init(document.getElementById('DayT'));
        var url = '${pageContext.request.contextPath}/GetDayTServlet';
        $.getJSON(url).done(function (json) {

            tMaxData = json.tMaxData;
            tMinData = json.tMinData;
            timeData = json.timeData;

            var option = {
                // color: ['#ffffff'],
                title: {
                    text: 'Daily Maximum and Minimum Value of Temperature',
                    subtext: 'Environment Info System',
                    x: 'center',
                    align: 'right'
                },
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'cross',
                        animation: false,
                        label: {
                            backgroundColor: '#505765'
                        }
                    }
                },
                legend: {
                    data: ['Temperature Max', 'Temperature Min'],
                    x: 'left'
                },
                dataZoom: [
                    {
                        show: true,
                        realtime: true,
                        start: 78,
                        end: 100
                    },
                    {
                        type: 'inside',
                        realtime: true,
                        start: 78,
                        end: 100
                    }
                ],
                xAxis: {
                    data: timeData
                },
                yAxis: [
                    {
                        type: 'value',
                        name: 'Temperature',
                        // min: 0,
                        // max: 250,
                        // interval: 50,
                        axisLabel: {
                            formatter: '{value} °C'
                        }
                    }
                ],
                series: [
                    {
                        name: 'Temperature Max',
                        type: 'line',
                        itemStyle: {
                            normal: {
                                color: '#ff0000'
                            }
                        },
                        data: tMaxData
                    }, {
                        name: 'Temperature Min',
                        type: 'line',
                        itemStyle: {
                            normal: {
                                color: '#00bfff'
                            }
                        },
                        data: tMinData
                    }
                ],
                toolbox: {
                    show: true,
                    feature: {
                        mark: {
                            show: true
                        },
                        dataView: {
                            show: true,
                            readOnly: false
                        },
                        magicType: {
                            show: true,
                            type: ['line', 'line']
                        },
                        restore: {
                            show: true
                        },
                        saveAsImage: {
                            show: true
                        }
                    }
                },
            }
            myChart.setOption(option);
        })
    }

    function DayHData() {
        var myChart = echarts.init(document.getElementById('DayH'));
        var url = '${pageContext.request.contextPath}/GetDayHServlet';
        $.getJSON(url).done(function (json) {

            hMaxData = json.hMaxData;
            hMinData = json.hMinData;
            timeData = json.timeData;

            var option = {
                // color: ['#ffffff'],
                title: {
                    text: 'Daily Maximum and Minimum Value of Humidity',
                    subtext: 'Environment Info System',
                    x: 'center',
                    align: 'right'
                },
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'cross',
                        animation: false,
                        label: {
                            backgroundColor: '#505765'
                        }
                    }
                },
                legend: {
                    data: ['Humidity Max', 'Humidity Min'],
                    x: 'left'
                },
                dataZoom: [
                    {
                        show: true,
                        realtime: true,
                        start: 78,
                        end: 100
                    },
                    {
                        type: 'inside',
                        realtime: true,
                        start: 78,
                        end: 100
                    }
                ],
                xAxis: {
                    data: timeData
                },
                yAxis: [
                    {
                        type: 'value',
                        name: 'Humidity',
                        // min: 0,
                        // max: 250,
                        // interval: 50,
                        axisLabel: {
                            formatter: '{value} %'
                        }
                    }
                ],
                series: [
                    {
                        name: 'Humidity Max',
                        type: 'line',
                        itemStyle: {
                            normal: {
                                color: '#ff0000'
                            }
                        },
                        data: hMaxData
                    }, {
                        name: 'Humidity Min',
                        type: 'line',
                        itemStyle: {
                            normal: {
                                color: '#00bfff'
                            }
                        },
                        data: hMinData
                    }
                ],
                toolbox: {
                    show: true,
                    feature: {
                        mark: {
                            show: true
                        },
                        dataView: {
                            show: true,
                            readOnly: false
                        },
                        magicType: {
                            show: true,
                            type: ['line', 'line']
                        },
                        restore: {
                            show: true
                        },
                        saveAsImage: {
                            show: true
                        }
                    }
                },
            }
            myChart.setOption(option);
        })
    }

    function DayPMData() {
        var myChart = echarts.init(document.getElementById('DayPM'));
        var url = '${pageContext.request.contextPath}/GetDayPMServlet';
        $.getJSON(url).done(function (json) {

            pmMaxData = json.pmMaxData;
            timeData = json.timeData;

            var option = {
                // color: ['#ffffff'],
                title: {
                    text: 'Daily Maximum value of PM2.5',
                    subtext: 'Environment Info System',
                    x: 'center',
                    align: 'right'
                },
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'cross',
                        animation: false,
                        label: {
                            backgroundColor: '#505765'
                        }
                    }
                },
                legend: {
                    data: ['PM2.5'],
                    x: 'left'
                },
                dataZoom: [
                    {
                        show: true,
                        realtime: true,
                        start: 78,
                        end: 100
                    },
                    {
                        type: 'inside',
                        realtime: true,
                        start: 78,
                        end: 100
                    }
                ],
                xAxis: {
                    data: timeData
                },
                yAxis: [
                    {
                        type: 'value',
                        name: 'PM2.5',
                        splitLine: {
                            show: false
                        },
                        // min: 0,
                        // max: 250,
                        // interval: 50,
                        axisLabel: {
                            formatter: '{value}'
                        }
                    }
                ],
                visualMap: {
                    top: 20,
                    right: 10,
                    pieces: [{
                        gt: 0,
                        lte: 80,
                        color: '#0000ff'
                    }, {
                        gt: 80,
                        lte: 160,
                        color: '#096'
                    }, {
                        gt: 160,
                        lte: 240,
                        color: '#ffde33'
                    }, {
                        gt: 240,
                        lte: 320,
                        color: '#ff9933'
                    }, {
                        gt: 320,
                        color: '#cc0033'
                    }],
                    outOfRange: {
                        color: '#999'
                    }
                },
                series: [
                    {
                        name: 'PM2.5',
                        type: 'line',
                        data: pmMaxData,
                        markLine: {
                            silent: true,
                            data: [{
                                yAxis: 80
                            }, {
                                yAxis: 160
                            }, {
                                yAxis: 240
                            }, {
                                yAxis: 320
                            }]
                        }
                    }
                ],
                toolbox: {
                    show: true,
                    feature: {
                        mark: {
                            show: true
                        },
                        dataView: {
                            show: true,
                            readOnly: false
                        },
                        magicType: {
                            show: true,
                            type: ['line']
                        },
                        restore: {
                            show: true
                        },
                        saveAsImage: {
                            show: true
                        }
                    }
                },
            }
            myChart.setOption(option);
        })
    }

    function DayCOData() {
        var myChart = echarts.init(document.getElementById('DayCO'));
        var url = '${pageContext.request.contextPath}/GetDayCOServlet';
        $.getJSON(url).done(function (json) {

            coMaxData = json.coMaxData;
            timeData = json.timeData;

            var option = {
                // color: ['#ffffff'],
                title: {
                    text: 'Daily Maximum Value of CO',
                    subtext: 'Environment Info System',
                    x: 'center',
                    align: 'right'
                },
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'cross',
                        animation: false,
                        label: {
                            backgroundColor: '#505765'
                        }
                    }
                },
                legend: {
                    data: ['CO'],
                    x: 'left'
                },
                dataZoom: [
                    {
                        show: true,
                        realtime: true,
                        start: 78,
                        end: 100
                    },
                    {
                        type: 'inside',
                        realtime: true,
                        start: 78,
                        end: 100
                    }
                ],
                xAxis: {
                    data: timeData
                },
                yAxis: [
                    {
                        type: 'value',
                        name: 'CO',
                        splitLine: {
                            show: false
                        },
                        // min: 0,
                        // max: 250,
                        // interval: 50,
                        axisLabel: {
                            formatter: '{value} ppm'
                        }
                    }
                ],
                visualMap: {
                    top: 20,
                    right: 10,
                    pieces: [{
                        gt: 0,
                        lte: 120,
                        color: '#096'
                    }, {
                        gt: 120,
                        lte: 180,
                        color: '#ff9933'
                    }, {
                        gt: 180,
                        color: '#cc0033'
                    }],
                    outOfRange: {
                        color: '#999'
                    }
                },
                series: [
                    {
                        name: 'CO',
                        type: 'line',
                        data: coMaxData,
                        markLine: {
                            silent: true,
                            data: [{
                                yAxis: 30
                            }, {
                                yAxis: 100
                            }]
                        }
                    }
                ],
                toolbox: {
                    show: true,
                    feature: {
                        mark: {
                            show: true
                        },
                        dataView: {
                            show: true,
                            readOnly: false
                        },
                        magicType: {
                            show: true,
                            type: ['line']
                        },
                        restore: {
                            show: true
                        },
                        saveAsImage: {
                            show: true
                        }
                    }
                },
            }
            myChart.setOption(option);
        })
    }

    $(function () {
        HourTHData();
    });

    $(function () {
        HourPMData();
    });

    $(function () {
        HourCOData();
    });

    $(function () {
        DayTData();
    });

    $(function () {
        DayHData();
    });

    $(function () {
        DayPMData();
    });

    $(function () {
        DayCOData();
    });

    $(function () {
        longpulling();
    });

    function longpulling() {
        $.ajax({
            url: '${pageContext.request.contextPath}/LongPollingServlet?client_id=<%=session.getAttribute("client_id")%>',
            type: 'get',
            dataType: 'text',
            timeout: 5000,
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                $("#longpolling").html("[state: " + textStatus + ", error: " + errorThrown + "]");
                longpulling();
            },
            success: function (data, textStatus) {
                var jsonObject = JSON.parse(data);
                $("#Time").html(jsonObject.time);
                $("#T").html(jsonObject.temperature);
                $("#H").html(jsonObject.humidity);
                $("#PM").html(jsonObject.pm2_5);
                $("#CO").html(jsonObject.co);
                if (jsonObject.temperature <= 0) {
                    $("#advice1").html("Cold cotton-padded clothes");
                } else if (jsonObject.temperature > 0 && jsonObject.temperature <= 15) {
                    $("#advice1").html("Cool jacket");
                } else if (jsonObject.temperature > 15 && jsonObject.temperature <= 25) {
                    $("#advice1").html("Warm T-shirt");
                } else if (jsonObject.temperature > 25) {
                    $("#advice1").html("Hot half-sleeve");
                }
                if (jsonObject.pm2_5 > 0 && jsonObject.pm2_5 <= 80) {
                    $("#advice2").html("Good: The air is suitable for exerciseing");
                } else if (jsonObject.pm2_5 > 80 && jsonObject.pm2_5 <= 160) {
                    $("#advice2").html("Well: The air is not bad for outdoor working");
                } else if (jsonObject.pm2_5 > 160 && jsonObject.pm2_5 <= 320) {
                    $("#advice2").html("Warning: Elders and Children are not suggested to walk outside");
                } else if (jsonObject.pm2_5 > 320) {
                    $("#advice2").html("Danger: Outdoor event are not suggedsted");
                }
                longpulling();
            }
        })
    }
</script>

</body>

</html>