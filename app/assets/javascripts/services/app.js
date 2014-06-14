var app = angular.module('app', ['snap', 'ngRoute', 'ngAnimate', 'ngCookies','google-maps', 'infinite-scroll', 'ipCookie']);
app.config(function($routeProvider){
    $routeProvider
    .when('/deals/outlets', {
        templateUrl: 'templates/outlet_view.html',
        controller: 'ListingController'
    })
    .when('/deals/map',{
        templateUrl: 'templates/map_view.html',
        controller: 'ListingController'
    })
    .when('/deals/shop',{
        templateUrl: 'templates/ad_outlet.html',
        controller: 'SingleOutletController'
    })
    .when('/home',{
        templateUrl: 'templates/home.html',
        controller: 'GeocodingController'
    })
    .when('/profile',{
        templateUrl: 'templates/profile.html',
        controller: 'GeocodingController'
    })
    .when('/',{
        templateUrl: 'templates/home.html',
        redirectTo: function(current, path, search){
            if(search.goto){
                console.log(search.goto);
            }
        }
    });
}).config(function(snapRemoteProvider){
    snapRemoteProvider.globalOptions.disable = 'right';
});
var domain   = '';//'http://api.shoffr.com/';
var app_type = 'html5'; //native or html5

app.controller('ViewController', function($scope){
    $scope.$on("$routeChangeSuccess", function(event, current, previous) {
        var previousCtrl = previous && previous.$$route && previous.$$route.controller;
        if (previousCtrl === "ListingController") {
            $scope.animationStyle = "slideLeft";
        } else if (previousCtrl === "SingleOutletController") {
            $scope.animationStyle = "slideRight";
        }
        $scope.$apply();
    });
})

