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

    #k, #m, #s, #v {
        display: none;
    }

    table {
        margin: 0 auto;
    }

    table td {
        padding: 0 10px;
    }

    #qrcode, #qrcode1, #qrcode2, #qrcodev {
        width: 110px;
        height: 110px;
        margin: 15px auto;
        background: #ffffff;
    }

    #qrcode img, #qrcode1 img, #qrcode2 img, #qrcodev img {
        padding: 5px;
    }
    </style>
    <script>
        var token = "${token}";
        var url = "${grailsApplication.config.grails.serverURL}/play/";
        var mode;
        var oneGame = angular.module('OneGame', []);
        oneGame.controller('myCtrl', function ($scope) {
            $scope.token = token;
            $scope.mode = "mobile";
            $scope.playUrl = function () {
                if ($scope.mode == "keyboard") {
                    return "Start game";
                }
                if ($scope.mode == "video") {
                    return (url + token + "v");
                }
                return (url + token);
            };
            $scope.modeChanged = function () {
                if ($scope.mode == "keyboard") {
                    window.location.assign(url + token);
                }
            };

            $scope.content = function () {
                var text = "";
                switch ($scope.mode) {
                    case "keyboard":
                        text = "CLick on below button to start game."
                        break;
                    case "mobile":
                        text = "Open link in mobile web browser Or scan QR code.";
                        break;
                    case "steering":
                        text = "Use URLs or QR code left and right respectively.";
                        break;
                    case "video":
                        text = "Use URLs or QR code to have a TV remote.";
                        break;
                }

                return text;
            };
        });

        var apiKey = "${apiKey}";
        var channelId = token;
        var eventName = "init";
        var eventCallback = function (data) {
            window.location.assign(url + token);
        };
        var peerId = token + "index";
        var peer = new Peer(peerId, {key: apiKey});

        peer.on('connection', function (conn) {
            conn.on('data', function (data) {
                if (data == "VIDEO") {
//                    window.open((url + token + "v"), 'OneGame', 'fullscreen=yes')
                    window.location.assign(url + token + "v");
                } else {
                    eventCallback(data);
                }
            });
        });
        $(document).ready(function () {
            var qrCode = function (el, url) {
                var qrcode = new QRCode(el, {
                    width: 100,
                    height: 100
                });
                qrcode.makeCode(url);
            };
            (function () {
                var u = (url + token);
                qrCode('qrcode', u);
                qrCode('qrcodev', u + "v");
                qrCode('qrcode1', u + "l");
                qrCode('qrcode2', u + "r");
            })();
        });
    </script>
</head>

<body id="page-top" ng-app="OneGame" ng-controller="myCtrl">
<header>
    <div class="header-content">
        <div class="header-content-inner">
            <h1>Want to play?</h1>
            <hr>

            <p>Choose your mode:</p>

            <div class="mode" ng-class="(mode=='keyboard') ? 'selected' : ''"><input id="k" type="radio" name="mode"
                                                                                     value="keyboard"
                                                                                     ng-model="mode"> <label
                    for="k">Keyboard</label></div>

            <div class="mode" ng-class="(mode=='mobile') ? 'selected' : ''"><input id="m" type="radio" name="mode"
                                                                                   value="mobile"
                                                                                   ng-model="mode">  <label
                    for="m">Mobile</label></div>

            <div class="mode" ng-class="(mode=='steering') ? 'selected' : ''"><input id="s" type="radio" name="mode"
                                                                                     value="steering"
                                                                                     ng-model="mode">  <label
                    for="s">Steering</label></div>

            <div class="mode" ng-class="(mode=='video') ? 'selected' : ''"><input id="v" type="radio" name="mode"
                                                                                  value="video"
                                                                                  ng-model="mode">  <label
                    for="v">TV</label></div>
            <br/>  <br/>  <br/>

            <p>{{content()}}</p>
            <table ng-show="mode=='steering'">
                <tr>
                    <td>
                        <div class="btn btn-primary btn-xl page-scroll"
                             style="text-transform: lowercase;font-size: xx-large">{{playUrl()+"l"}}</div>
                    </td>
                    <td>
                        <div class="btn btn-primary btn-xl page-scroll"
                             style="text-transform: lowercase;font-size: xx-large">{{playUrl()+"r"}}</div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="qrcode1"></div>
                    </td>
                    <td>
                        <div id="qrcode2"></div>
                    </td>
                </tr>
            </table>

            <div class="btn btn-primary btn-xl page-scroll" ng-hide="mode=='steering'"
                 style="text-transform: lowercase;font-size: xx-large" ng-click="modeChanged()">{{playUrl()}}</div>

            <div id="qrcode" ng-show="mode=='mobile'"></div>

            <div id="qrcodev" ng-show="mode=='video'"></div>
        </div>
    </div>
</header>
%{--

<section class="bg-primary" id="about">
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 text-center">
                <h2 class="section-heading">Your scores</h2>
                <hr class="light">

                <p class="text-faded">Start Bootstrap has everything you need to get your new website up and running in no time! All of the templates and themes on Start Bootstrap are open source, free to download, and easy to use. No strings attached!</p>
                <a href="#" class="btn btn-default btn-xl">Get Started!</a>
            </div>
        </div>
    </div>
</section>

<section class="no-padding" id="portfolio">
    <div class="container-fluid">
        <div class="row no-gutter">
            <div class="col-lg-4 col-sm-6">
                <a href="#" class="portfolio-box">
                    <img src=" ${resource(dir: 'images/portfolio', file: '1.jpg')}" class="img-responsive" alt="">

                    <div class="portfolio-box-caption">
                        <div class="portfolio-box-caption-content">
                            <div class="project-category text-faded">
                                Category
                            </div>

                            <div class="project-name">
                                Project Name
                            </div>
                        </div>
                    </div>
                </a>
            </div>

            <div class="col-lg-4 col-sm-6">
                <a href="#" class="portfolio-box">
                    <img src=" ${resource(dir: 'images/portfolio', file: '2.jpg')}" class="img-responsive" alt="">

                    <div class="portfolio-box-caption">
                        <div class="portfolio-box-caption-content">
                            <div class="project-category text-faded">
                                Category
                            </div>

                            <div class="project-name">
                                Project Name
                            </div>
                        </div>
                    </div>
                </a>
            </div>

            <div class="col-lg-4 col-sm-6">
                <a href="#" class="portfolio-box">
                    <img src=" ${resource(dir: 'images/portfolio', file: '3.jpg')}" class="img-responsive" alt="">

                    <div class="portfolio-box-caption">
                        <div class="portfolio-box-caption-content">
                            <div class="project-category text-faded">
                                Category
                            </div>

                            <div class="project-name">
                                Project Name
                            </div>
                        </div>
                    </div>
                </a>
            </div>

            <div class="col-lg-4 col-sm-6">
                <a href="#" class="portfolio-box">
                    <img src=" ${resource(dir: 'images/portfolio', file: '4.jpg')}" class="img-responsive" alt="">

                    <div class="portfolio-box-caption">
                        <div class="portfolio-box-caption-content">
                            <div class="project-category text-faded">
                                Category
                            </div>

                            <div class="project-name">
                                Project Name
                            </div>
                        </div>
                    </div>
                </a>
            </div>

            <div class="col-lg-4 col-sm-6">
                <a href="#" class="portfolio-box">
                    <img src=" ${resource(dir: 'images/portfolio', file: '5.jpg')}" class="img-responsive" alt="">

                    <div class="portfolio-box-caption">
                        <div class="portfolio-box-caption-content">
                            <div class="project-category text-faded">
                                Category
                            </div>

                            <div class="project-name">
                                Project Name
                            </div>
                        </div>
                    </div>
                </a>
            </div>

            <div class="col-lg-4 col-sm-6">
                <a href="#" class="portfolio-box">
                    <img src=" ${resource(dir: 'images/portfolio', file: '6.jpg')}" class="img-responsive" alt="">

                    <div class="portfolio-box-caption">
                        <div class="portfolio-box-caption-content">
                            <div class="project-category text-faded">
                                Category
                            </div>

                            <div class="project-name">
                                Project Name
                            </div>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </div>
</section>
--}%

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