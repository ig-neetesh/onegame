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
    <style>
    img {
        -ms-transform: rotate(90deg); /* IE 9 */
        -webkit-transform: rotate(90deg); /* Chrome, Safari, Opera */
        transform: rotate(90deg);
    }
    </style>
    <script>
        var steeringImage = "${resource(dir: 'images',file: 'steering.jpg')}";
        var token = "${token}";
        var steeringUrl = "${g.createLink(controller: 'steering',action: 'control')}";
        var interval = "${interval}";

        $(document).ready(function () {
            var mobileInitiated = false;
            var steeringData = {
                x: 0,
                y: 0,
                z: 0,
                token: token
            };

            var toNumber = function (point) {
                return isNaN(point) ? -1000 : point;
            };

            var registerDeviceMotionEvent = function () {
                if (window.DeviceMotionEvent) {
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
                }
            };

            var sendSteeringInfo = function () {
                $.ajax({
                    type: "POST",
                    url: steeringUrl,
                    data: steeringData,
                    success: function (data) {
                        //TODO don't know what to do with this data
                    }
                });
            };

            var initiateTimer = function (interval) {
                return setInterval(function () {
                    sendSteeringInfo();
                }, interval);
            };


            var gameStarted = false;
            $("#start").on("click", function (e) {
                console.log(e);
                if (!gameStarted) {
                    gameStarted = true;
                    var img = e.target;
                    $(img).attr("src", steeringImage);
                    initiateTimer(interval);
                }
            });
        });
    </script>
</head>

<body>
<img id="start" src="${resource(dir: 'images', file: 'start_button.gif')}">
</body>
</html>