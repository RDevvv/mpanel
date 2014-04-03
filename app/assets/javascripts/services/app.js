var app = angular.module('app', ['ngRoute', 'ngCookies']);
app.config(function($routeProvider){
    $routeProvider
    .when('/outlet_view', {
        templateUrl: '/templates/outlet_view.html',
        controller: 'ListingController'
    })
    .when('/map_view',{
        templateUrl: '/templates/map_view.html',
        controller: 'ListingController'
    })
    .when('/',{
        templateUrl: '/templates/home.html'
    })
    .otherwise({redirectTo: '/templates/home.html'})
});