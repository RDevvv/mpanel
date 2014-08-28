var app = angular.module('app', ['snap', 'ngRoute', 'ngAnimate', 'ngCookies','google-maps', 'infinite-scroll', 'ipCookie', 'ngTagsInput', 'restangular']);
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
    .when('/brands/:brand_id/facebook',{
        templateUrl: 'templates/facebook.html',
        controller: 'FacebookController'
    })
    .when('/brands/:brand_id/twitter',{
        templateUrl: 'templates/twitter.html',
        controller: 'TweetsController'
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
    .when('/product/:id',{
        templateUrl: 'templates/product.html',
        controller: 'ProductController'
    })
    .when('/sweepstakes',{
        templateUrl: 'templates/sweepstakes.html'
    })
    .otherwise({
        templateUrl: 'templates/home.html',
        controller: 'GeocodingController'
    });
}).config(function(snapRemoteProvider, RestangularProvider){
    snapRemoteProvider.globalOptions.disable = 'right';
    snapRemoteProvider.globalOptions.touchToDrag = false;
    RestangularProvider.setRequestSuffix('.json');
    RestangularProvider.setBaseUrl('merchant');
});

var domain   = '';//'http://api.shoffr.com/';
var app_type = 'html5'; //native or html5
var account_id = 1;

