<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
    <style type="text/css">
        body, html, #allmap {
            width: 100%;
            height: 100%;
            overflow: hidden;
            margin: 0%;
            font-family: "微软雅黑";
        }
    </style>
    <script type="text/javascript"
            src="http://api.map.baidu.com/api?v=2.0&ak=8k8Z7fzSAgjtDEIOz5DfLhErIQUITeo9"></script>
    <title>Baidu Map Test</title>
</head>
<body>
<center>
    <h1>Environment Monitoring System</h1>
</center>
<div id="allmap" align="center"></div>
</body>
</html>

<%
    List list = (List) session.getAttribute("clientList");
    out.print("<script>");
    out.print("var map = new BMap.Map(\"allmap\");\n");


    out.print("    var points = new Array();\n" +
            "    var markers = new Array();" +
            "    var labels = new Array();");

    for (int i = 0; i < list.size(); i++) {
        Map map = (Map) list.get(i);
        out.print("points[" + i + "] = new BMap.Point(" + map.get("longitude") + ", " + map.get("latitude") + ");");
        out.print("markers[" + i + "] = new BMap.Marker(points[" + i + "]);");
        out.print("map.addOverlay(markers[" + i + "]);");
    }

    out.print("  var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});\n" +
            "    var top_left_navigation = new BMap.NavigationControl();\n" +
            "    var top_right_navigation = new BMap.NavigationControl({\n" +
            "        anchor: BMAP_ANCHOR_TOP_RIGHT,\n" +
            "        type: BMAP_NAVIGATION_CONTROL_SMALL\n" +
            "    });\n" +
            "\n" +
            "    map.addControl(top_left_control);\n" +
            "    map.addControl(top_left_navigation);\n" +
            "    map.addControl(top_right_navigation);\n" +
            "\n" +
            "    map.enableScrollWheelZoom();\n" +
            "    map.enableContinuousZoom();");


    for (int i = 0; i < list.size(); i++) {
        out.print("markers[" + i + "].addEventListener(\"click\",getAttr" + i + ");\n" +
                "        function getAttr" + i + "(){\n" +
                "            var id =" + (i + 1) + ";\n" +
                "            window.location.href = \"DetialServlet?id=\" + id;\n" +
                "        }");
    }

    for (int i = 0; i < list.size(); i++) {
        Map map = (Map) list.get(i);
        out.print("labels[" + i + "] = new BMap.Label(\"" + map.get("location") + "\", {offset: new BMap.Size(20, -10)});");
        out.print("markers[" + i + "].setLabel(labels[" + i + "]);");
    }

    out.print("map.centerAndZoom(points[0], 18);");
    out.print("</script>");
%>