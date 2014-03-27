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

app.controller('ListingController', ['$scope', '$http', '$routeParams', '$cookies', function($scope, $http, $routeParams, $cookies){
    $http({
        method: 'GET',
        url: 'outlet_listing.json',
        params :{location: $routeParams['location'], view: $routeParams['view'], search: $routeParams['search'], filter: $routeParams['filter'] }
    })
    .then(function(response){
        console.log($cookies.mobile_number);
        $scope.posters = response.data;
    });

    $scope.verified = function(){
        if($cookies.mobile_number=='verified')
            return true;
    }

    $scope.unlock = function (brand_name,ad_id, outlet_id) {
        $http({
            method: 'POST',
            url   : 'set_sms_data.json',
            params: {
                customer_uuid: $cookies.customer_uuid,
                ad_id: ad_id,
                outlet_id: outlet_id
            }
        })
        $.pnotify({
            title: brand_name+' - Offer sent',
            text: 'text',
            sticker_hover: false,
            closer_hover: false,
            animate_speed: 'fast',
            icon: false,
            addclass: 'stack-topleft',
            opacity: .9
        });
    }

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

    $scope.tracking = function(ad_id,outlet_id,button_class, current_link){
        $http({
            method: 'POST',
            url: 'get_button_click.json',
            params: {
                customer_uuid: '0cbac1e3-7792-49a5-b185-da3a75ac94d0',
                ad_id: ad_id,
                outlet_id: outlet_id,
                button_class: button_class,
                current_link: current_link
            }
        })

    }
}])
