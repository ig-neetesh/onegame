<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<g:set var="img" value="${resource(dir: 'images', file: 'remote.jpg')}"/>
<g:set var="volUp" value="${resource(dir: 'images', file: 'volUp.jpg')}"/>
<g:set var="volDown" value="${resource(dir: 'images', file: 'volDown.jpg')}"/>
<head>
    <title>TV Remote</title>
    <script src="${resource(dir: 'js', file: 'peer.js')}"></script>
    <style>
    button {
        width: 200px;
        height: 200px;
        border: none;
        background-image: url("${img}");
    }

    #play {
        background-position-x: -50px;
        background-position-y: -40px;
    }

    .pause {
        background-position-x: -273px !important;
        background-position-y: -40px !important;
    }

    #back {
        background-position-x: -501px;
        background-position-y: -489px;
    }

    #next {
        background-position-x: -271px;
        background-position-y: -488px;
    }

    #volUp {
        background-image: url("${volUp}");
    }

    #volDown {
        background-image: url("${volDown}");
    }

    #mute {
        background-position-x: -46px;
        background-position-y: -718px;
    }

    .unmute {
        background-position-x: -274px !important;
        background-position-y: -718px !important;
    }

    #close {
        background-position-x: -733px !important;
        background-position-y: -950px !important;
    }
    </style>
    <script>
        var key = null;
        (function () {
            var apiKey = "${apiKey}";
            var token = "${token}";
            if (token.endsWith("v")) {
                token = token.replace("v", "");
            }
            var peerId = token + "remote";
            var peer = new Peer(peerId, {key: apiKey});

            var conn = peer.connect(token + "index");

            peer.on('connection', function (conn) {
                conn.on('data', function (data) {
                    if (data == "VIDEO_PAGE_LOADED") {
                        var connVideo = peer.connect(token + "video");
                        connVideo.on('open', function () {
                            setInterval(function () {
                                if (key != null) {
                                    connVideo.send(key);
                                    key = null;
                                }
                            }, 5);
                        });
                    }
                });
            });

            conn.on('open', function () {
                conn.send('VIDEO');
            });
        })();
        function sendKey(k) {
            key = k;
        }
    </script>
</head>

<body>
<table>
    <tr>
        <td>
            <button id="close" onclick="sendKey('V_CLOSE')"></button>
        </td>
        <td>

        </td>
        <td>
            <button id="mute" onclick="sendKey('V_TOGGLE_MUTE')"></button>
        </td>
    </tr>
    <tr>
        <td>

        </td>
        <td>

        </td>
        <td>

        </td>
    </tr>
    <tr>
        <td>

        </td>
        <td>
            <button id="volUp" onclick="sendKey('V_VOL_UP')"></button>
        </td>
        <td>

        </td>
    </tr>
    <tr>
        <td>
            <button id="back" onclick="sendKey('V_BACK')"></button>
        </td>
        <td>
            <button id="play" class="" onclick="sendKey('V_PLAY')"></button>
        </td>
        <td>
            <button id="next" onclick="sendKey('V_NEXT')"></button>
        </td>
    </tr>
    <tr>
        <td>

        </td>
        <td>
            <button id="volDown" onclick="sendKey('V_VOL_DOWN')"></button>
        </td>
        <td>

        </td>
    </tr>
</table>
</body>
</html>
