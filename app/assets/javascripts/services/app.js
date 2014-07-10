var app = angular.module('app', ['snap', 'ngRoute', 'ngAnimate', 'ngCookies','google-maps', 'infinite-scroll', 'ipCookie', 'ngTagsInput']);
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
    .when('/shopping_list',{
        templateUrl: 'templates/shopping_list.html',
        controller: 'ShoppingListController'
    })
    .otherwise({
        redirectTo: '/home'
    });
}).config(function(snapRemoteProvider){
    snapRemoteProvider.globalOptions.disable = 'right';
    snapRemoteProvider.globalOptions.touchToDrag = false;
});
var domain   = '';//'http://api.shoffr.com/';
var app_type = 'html5'; //native or html5

