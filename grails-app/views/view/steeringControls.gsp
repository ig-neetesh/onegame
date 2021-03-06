<%--
  Created by IntelliJ IDEA.
  User: neetesh
  Date: 26/9/15
  Time: 3:56 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>OneGame</title>
    <script src="${resource(dir: 'js', file: 'jquery-1.11.3.min.js')}"></script>
    <script src="${resource(dir: 'js', file: 'peer.js')}"></script>
    <style>
    img {
        -ms-transform: rotate(90deg); /* IE 9 */
        -webkit-transform: rotate(90deg); /* Chrome, Safari, Opera */
        transform: rotate(90deg);
        position: fixed;
        top: 38%;
    }

    .imgc {
        margin: 0 auto;
        width: 226px;
    }
    </style>
    <script>
        var steeringImage = "${resource(dir: 'images',file: 'steering.jpg')}";
        var apiKey = "${apiKey}";

        $(document).ready(function () {
            var token = $("#token").val();
            var mainToken = token;
            var dual = false;
            if (token.endsWith("l") || token.endsWith("r")) {
                dual = true;
                token = token.replace("l", "");
                token = token.replace("r", "");
            }
            var interval = $("#interval").val();
            console.log("Token : " + token);
            var mobileInitiated = false;
            var steeringData = {
                x: 0,
                y: 0,
                z: 0,
                token: token,
                dual: dual
            };

            var toNumber = function (point) {
                return isNaN(point) ? -1000 : point;
            };

            (function () {
                if (window.DeviceMotionEvent) {
                    console.log("working");
                    window.addEventListener('devicemotion', function (event) {
                        var x = event.accelerationIncludingGravity.x;
                        var y = event.accelerationIncludingGravity.y;
                        var z = event.accelerationIncludingGravity.z;

                        steeringData = {
                            x: toNumber(x),
                            y: toNumber(y),
                            z: toNumber(z),
                            token: token
                        };
                    });
                } else {
                    //TODO : You device does not support this game switch to CHrome
                    console.log("Not working");
                }
            })();

            var peerId = mainToken + "steering";
            var peer = new Peer(peerId, {key: apiKey});

            var conn = peer.connect(token + "index");

            var connDisplay;
            peer.on('connection', function (conn) {
                conn.on('data', function (data) {
                    connDisplay = peer.connect(token + "display");
                    initiateTimer(interval);
                });
            });

            conn.on('open', function () {
                conn.send('INIT');
            });

            var initiateTimer = function (interval) {
                connDisplay.on('open', function () {
                    setInterval(function () {
                        connDisplay.send(steeringData);
                    }, 5);
                });
            };

            var gameStarted = false;
            $("#start").on("click", function (e) {
                if (!gameStarted) {
                    gameStarted = true;
                    var img = e.target;
                    $(img).attr("src", steeringImage);
                }
            });
        });
    </script>
</head>

<body id="myBody">
<div class="imgc">
    <img id="start" src="${resource(dir: 'images', file: 'start_button.gif')}" width="213" height="213">
</div>
<input type="hidden" id="token" value="${token}">
<input type="hidden" id="interval" value="${interval}">
</body>
</html>