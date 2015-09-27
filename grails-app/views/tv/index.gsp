<!DOCTYPE html>
<html>
<head>
    <script src="${resource(dir: 'js', file: 'angular.min.js')}"></script>
</head>

<body>
<script>
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
                height: '390',
                width: '640',
                videoId: v,
                events: {
                    'onReady': onPlayerReady,
                    'onStateChange': onPlayerStateChange
                }
            });
            this.play = function () {
                playUnit.playVideo();
                var playerElement = document.getElementById("player" + v);
                var requestFullScreen = playerElement.requestFullScreen || playerElement.mozRequestFullScreen || playerElement.webkitRequestFullScreen;
                if (requestFullScreen) {
                    requestFullScreen.bind(playerElement)();
                }
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
        $scope.videos = ["WnB1TGUVmNA", "RA1Hyy6TTx8", "3lNy350VSzo", "zXnZgZMDoEs", "A8tCF-K5qJ4", "HUhDkWrNzIk", "6FkG-Bh9J9c", "A0Gb2fvjKYo", "Gc4HGQHgeFE", "v9oxyswY8fs"];
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
                return $scope.currentPlayer;
            };
            var back = function () {
                var idx = $scope.currentPlayerIndex;
                if (idx > -1) {
                    $scope.currentPlayer = $scope.players[idx - 1];
                    $scope.currentPlayerIndex = idx - 1;
                }
                return $scope.currentPlayer;
            };
            var pl = new Player(v, next, back);
            if ($scope.currentPlayer == null) {
                $scope.currentPlayer = pl;
                $scope.currentPlayerIndex = 0;
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
</script>

<div ng-app="OneTV" ng-controller="myRemote">

    <div ng-repeat="video in videos track by $index">
        <div id="{{'player'+video}}"></div>
    </div>
    {{init()}}
    <button ng-click="currentPlayer.play()">Play</button>

    <button ng-click="currentPlayer.back()">Back</button>

    <button ng-click="currentPlayer.next()">Next</button>

    <button ng-click="currentPlayer.toggleMute()">Mute</button>
    <button ng-click="currentPlayer.toggleMute()">Un-Mute</button>

    <button ng-click="currentPlayer.volumeUp()">Vol +</button>

    <button ng-click="currentPlayer.volumeDown()">Vol -</button>
</div>

</body>
</html>