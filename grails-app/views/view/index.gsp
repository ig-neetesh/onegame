<!DOCTYPE html>
<html lang="en">

<head>
    <title>OneGame</title>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap.min.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'creative.css')}" type="text/css">
    <script src="${resource(dir: 'js', file: 'angular.min.js')}"></script>
    <script>
        var token = "${token}";
        var url = "${grailsApplication.config.grails.serverURL}/play/";
        var oneGame = angular.module('OneGame', []);
        oneGame.controller('myCtrl', function ($scope) {
            $scope.token = token;
            $scope.playUrl = function () {
                return (url + token);
            };
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
            <input type="radio" name="mode" value="keyboard"> Keyboard <br>
            <input type="radio" name="mode" value="mobile"> Mobile <br>
            <input type="radio" name="mode" value="steering"> Steering <br>

            <div class="btn btn-primary btn-xl page-scroll">{{playUrl()}}</div>
        </div>
    </div>
</header>

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

                <p><a href="mailto:techathon1game@gmail.com">techathon1game@gmail.com</a></p>
            </div>
        </div>
    </div>
</section>

</body>

</html>