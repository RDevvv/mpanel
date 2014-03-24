var app = angular.module('app', ['ngRoute']);
app.config(function($routeProvider){
    $routeProvider
    .when('/outlet_view', {
        templateUrl: '/templates/outlet_listingg.html',
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

app.controller('ListingController', ['$scope', '$http', '$routeParams', function($scope, $http, $routeParams){
    $http({
        method: 'GET',
        url: 'outlet_listing.json',
        params :{location: $routeParams['location'], view: $routeParams['view'], search: $routeParams['search'] }
    });
}])
