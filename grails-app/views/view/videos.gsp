<!DOCTYPE html>
<html lang="en">

<head>
    <title>OneGame</title>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.min.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'creative.css')}" type="text/css">
    <script src="${resource(dir: 'js', file: 'jquery-1.11.3.min.js')}"></script>
    <script src="${resource(dir: 'js', file: 'qrcode.js')}"></script>
    <script src="${resource(dir: 'js', file: 'angular.min.js')}"></script>
    <script src="${resource(dir: 'js', file: 'peer.js')}"></script>
    <style>
    .selected {
        background: #f05f40;
    }

    .mode {
        width: 200px;
        border: 1px solid #cccccc;
        display: inline-block;
        font-size: 30px;
        cursor: pointer;
    }

    #k, #m, #s {
        display: none;
    }

    table {
        margin: 0 auto;
    }

    table td {
        padding: 0 10px;
    }

    #qrcode, #qrcode1, #qrcode2 {
        width: 110px;
        height: 110px;
        margin: 15px auto;
        background: #ffffff;
    }

    #qrcode img, #qrcode1 img, #qrcode2 img {
        padding: 5px;
    }

    .col-lg-4 {
        padding: 0;
        height: 200px;
    }

    .bo {
        overflow: hidden;
    }

    .fullScreen {
        position: absolute;
        width: 100%;
        height: 100%;
        z-index: 5;
    }
    </style>
    <script>
        var playerUnit;
        var allVideos = ["RA1Hyy6TTx8", "WnB1TGUVmNA", "3lNy350VSzo", "zXnZgZMDoEs", "A8tCF-K5qJ4", "HUhDkWrNzIk", "6FkG-Bh9J9c", "A0Gb2fvjKYo", "Gc4HGQHgeFE"];
        var doFullScreen = function (v) {
            for (i = 0; i < allVideos.length; i++) {
                var vID = allVideos[i];
                if (v == vID) {
                    $("#player" + vID).parent().attr("class", "fullScreen");
                } else {
                    $("#player" + vID).parent().attr("class", "col-lg-4 col-sm-6");
                }
            }
        };
        var tv = angular.module('OneTV', []);
        tv.controller('myRemote', function ($scope) {
            var Player = function (v, next, back) {
                var onPlayerStateChange = function () {
                    if (event.data == YT.PlayerState.PLAYING && !done) {
//                setTimeout(stopVideo, 6000);
//                done = true;
                    }
                };
                var onPlayerReady = function () {
                };
                var playUnit = new YT.Player('player' + v, {
                    height: '100%',
                    width: '100%',
                    videoId: v,
                    events: {
                        'onReady': onPlayerReady,
                        'onStateChange': onPlayerStateChange
                    }
                });
                this.play = function () {
                    playUnit.playVideo();
                    /*                var playerElement = document.getElementById("player" + v);
                     var requestFullScreen = playerElement.requestFullScreen || playerElement.mozRequestFullScreen || playerElement.webkitRequestFullScreen;
                     if (requestFullScreen) {
                     requestFullScreen.bind(playerElement)();
                     }*/
                    doFullScreen(v);
                };
                this.pause = function () {
                    playUnit.stopVideo();
                };
                this.volumeUp = function () {
                    var vol = playUnit.getVolume();
                    var newVol = vol + 10;
                    if (newVol <= 100) {
                        playUnit.setVolume(newVol);
                    }
                };
                this.volumeDown = function () {
                    var vol = playUnit.getVolume();
                    var newVol = vol - 10;
                    if (newVol >= 0) {
                        playUnit.setVolume(newVol);
                    }
                };
                this.next = function () {
                    this.pause();
                    var pl = next();
                    pl.play();
                };
                this.back = function () {
                    this.pause();
                    var pl = back();
                    pl.play();
                };
                this.switchOff = function () {
                };
                this.toggleMute = function () {
                    playUnit.unMute()
                    if (playUnit.isMuted()) {
                    } else {
                        playUnit.mute();
                    }
                };
            };
            $scope.videos = allVideos;
            $scope.currentVideo = "WnB1TGUVmNA";
            $scope.players = [];
            $scope.currentPlayer = null;
            $scope.currentPlayerIndex = -1;
            $scope.initPlayer = function (v) {
                var next = function () {
                    var idx = $scope.currentPlayerIndex;
                    if (idx < $scope.players.length) {
                        $scope.currentPlayer = $scope.players[idx + 1];
                        $scope.currentPlayerIndex = idx + 1;
                    }
                    playerUnit = $scope.currentPlayer;
                    return $scope.currentPlayer;
                };
                var back = function () {
                    var idx = $scope.currentPlayerIndex;
                    if (idx > -1) {
                        $scope.currentPlayer = $scope.players[idx - 1];
                        $scope.currentPlayerIndex = idx - 1;
                    }
                    playerUnit = $scope.currentPlayer;
                    return $scope.currentPlayer;
                };
                var pl = new Player(v, next, back);
                if ($scope.currentPlayer == null) {
                    $scope.currentPlayer = pl;
                    $scope.currentPlayerIndex = 0;
                    playerUnit = $scope.currentPlayer;
                }
                $scope.players.push(pl);
            };
            $scope.init = function () {
                var tag = document.createElement('script');
                tag.src = "https://www.youtube.com/iframe_api";
                var firstScriptTag = document.getElementsByTagName('script')[0];
                firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
                window.onYouTubeIframeAPIReady = function () {
                    var vid = $scope.videos[0];
                    $scope.addAll();
                };
            };
            $scope.addAll = function () {
                var log = [];
                var values = $scope.videos;
                angular.forEach(values, function (v) {
                    $scope.initPlayer(v);
                }, log);
            };
        });

        var processKey = function (k) {
            switch (k) {
                case "V_PLAY":
                    playerUnit.play();
                    break;
                case "V_PAUSE":
                    playerUnit.pause();
                    break;
                case "V_NEXT":
                    playerUnit.next();
                    break;
                case "V_BACK":
                    playerUnit.back();
                    break;
                case "V_VOL_UP":
                    playerUnit.volumeUp();
                    break;
                case "V_VOL_DOWN":
                    playerUnit.volumeDown();
                    break;
                case "V_TOGGLE_MUTE":
                    playerUnit.toggleMute();
                    break;
                case "V_CLOSE":
                    window.close();
                    break;
            }
        };

        var apiKey = "${apiKey}";
        var token = "${token}";
        if (token.endsWith("v")) {
            token = token.replace("v", "");
        }
        var peerId = token + "video";
        var peer = new Peer(peerId, {key: apiKey});

        var conn = peer.connect(token + "remote");

        var connVideo;
        peer.on('connection', function (conn) {
            conn.on('data', function (data) {
                console.log(data);
                processKey(data);
            });
        });

        conn.on('open', function () {
            conn.send('VIDEO_PAGE_LOADED');
        });
    </script>
</head>

<body id="page-top" class="bo">
<section class="no-padding" id="portfolio">

    <div class="container-fluid">
        <div class="row no-gutter" ng-app="OneTV" ng-controller="myRemote">
            <div ng-repeat="video in videos track by $index">
                <div class="col-lg-4 col-sm-6">
                    <div id="{{'player'+video}}"></div>
                </div>
            </div>
            {{init()}}
        </div>
    </div>
</section>

<section id="contact">
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 text-center">
                <h2 class="section-heading">Let's Get In Touch!</h2>
                <hr class="primary">

                <p>Ready to start your next project with us? That's great! Give us a call or send us an email and we will get back to you as soon as possible!</p>
            </div>

            <div class="col-lg-4 col-lg-offset-2 text-center">
                <i class="fa fa-phone fa-3x wow bounceIn"></i>

                <p>+91-8802773141</p>
            </div>

            <div class="col-lg-4 text-center">
                <i class="fa fa-envelope-o fa-3x wow bounceIn" data-wow-delay=".1s"></i>

                <p><a href="mailto:techathon1game@gmail.com">neetesh.bhardwaj@tothenew.com</a></p>
            </div>
        </div>
    </div>
</section>

</body>

</html>