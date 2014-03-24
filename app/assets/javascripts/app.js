var app = angular.module('app', ['ngRoute']);
app.config(function($routeProvider){
    $routeProvider
    .when('/outlet_listing', {
        templateUrl: 'outlet_listing.html'
    })
    .when('/',{
        templateUrl: 'index.html'
    })
    .otherwise({redirectTo: 'index.html'})
});
