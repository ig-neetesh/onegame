<!DOCTYPE html>

<html>
<head>
    <title>OneGame</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="${resource(dir: 'css', file: 'common.css')}" rel="stylesheet" type="text/css"/>
</head>

<body>

<table id="controls" style="display: none">
    <tr><td id="fps" colspan="2" align="right"></td></tr>
    <tr>
        <th><label for="resolution">Resolution :</label></th>
        <td>
            <select id="resolution" style="width:100%">
                <option value='fine'>Fine (1280x960)</option>
                <option selected value='high'>High (1024x768)</option>
                <option value='medium'>Medium (640x480)</option>
                <option value='low'>Low (480x360)</option>
            </select>
        </td>
    </tr>
    <tr>
        <th><label for="lanes">Lanes :</label></th>
        <td>
            <select id="lanes">
                <option>1</option>
                <option>2</option>
                <option selected>3</option>
                <option>4</option>
            </select>
        </td>
    </tr>
    <tr>
        <th><label for="roadWidth">Road Width (<span id="currentRoadWidth"></span>) :</label></th>
        <td><input id="roadWidth" type='range' min='500' max='3000' title="integer (500-3000)"></td>
    </tr>
    <tr>
        <th><label for="cameraHeight">CameraHeight (<span id="currentCameraHeight"></span>) :</label></th>
        <td><input id="cameraHeight" type='range' min='500' max='5000' title="integer (500-5000)"></td>
    </tr>
    <tr>
        <th><label for="drawDistance">Draw Distance (<span id="currentDrawDistance"></span>) :</label></th>
        <td><input id="drawDistance" type='range' min='100' max='500' title="integer (100-500)"></td>
    </tr>
    <tr>
        <th><label for="fieldOfView">Field of View (<span id="currentFieldOfView"></span>) :</label></th>
        <td><input id="fieldOfView" type='range' min='80' max='140' title="integer (80-140)"></td>
    </tr>
    <tr>
        <th><label for="fogDensity">Fog Density (<span id="currentFogDensity"></span>) :</label></th>
        <td><input id="fogDensity" type='range' min='0' max='50' title="integer (0-50)"></td>
    </tr>
</table>

<div id='instructions' style="display: none">
    <p>Use the <b>arrow keys</b> to drive the car.</p>
</div>

<div id="racer">
    <div id="hud">
        <span id="speed" class="hud"><span id="speed_value" class="value">0</span> mph</span>
        <span id="current_lap_time" class="hud">Time: <span id="current_lap_time_value" class="value">0.0</span></span>
        <span id="last_lap_time" class="hud">Last Lap: <span id="last_lap_time_value" class="value">0.0</span></span>
        <span id="fast_lap_time" class="hud">Fastest Lap: <span id="fast_lap_time_value" class="value">0.0</span></span>
    </div>
    <canvas id="canvas">
        Sorry, OneGame cannot be run because your browser does not support the &lt;canvas&gt; element
    </canvas>
</div>

<audio id='music'>
    <source src="music/racer.ogg">
    <source src="${resource(dir: 'music', file: 'racer.mp3')}">
</audio>
<span id="mute"></span>
<script>
    var imagePath = "${grailsApplication.config.grails.serverURL}/images";
</script>
<script src="${resource(dir: 'js', file: 'stats.js')}"></script>
<script src="${resource(dir: 'js', file: 'common.js')}"></script>
<script src="${resource(dir: 'js', file: 'play.js')}"></script>
<script src="https://js.pusher.com/3.0/pusher.min.js"></script>
<script>
    var apiKey = "${apiKey}";
    var channelId = "${channelId}";
</script>
<script src="${resource(dir: 'js', file: 'control.js')}"></script>
</body>
</html>