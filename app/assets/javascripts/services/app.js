var app = angular.module('app', ['ngRoute', 'ngCookies','google-maps', 'infinite-scroll']);
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
        controller: 'GeocodingController'
    })
    .otherwise({redirectTo: 'templates/home.html'})
});
var domain   = ''; //'http://api.shoffr.com/';
var app_type = 'html5'; //native or html5

