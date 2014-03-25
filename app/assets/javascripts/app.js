var app = angular.module('app', ['ngRoute']);
app.config(function($routeProvider){
    $routeProvider
    .when('/outlet_view', {
        templateUrl: '/templates/outletview.html',
        controller: 'ListingController'
    })
    .when('/map_view',{
        templateUrl: '/templates/poster.html',
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
    })
        .then(function(response){
    $scope.posters = response.data;
    });

    $scope.view_ad = function(brand_name, title, sms_text){
        $.pnotify({ title: brand_name+' - '+title, text: sms_text,
        closer_hover: false,
        sticker_hover: false,
        animate_speed: 'fast',
        icon: false,
        addclass: 'stack-topleft',
        opacity: .9
    });
    }
}])
