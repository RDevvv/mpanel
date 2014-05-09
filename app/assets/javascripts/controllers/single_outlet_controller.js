app.controller('SingleOutletController', function($scope, $http, $routeParams, $cookies){
    $scope.map = {
        user_icon: 'http://shoffr.com/assets/user_pin.png',
        icon: 'http://maps.google.com/mapfiles/markerA.png',
        center: {latitude: $routeParams['customer_latitude'], longitude: $routeParams['customer_longitude']},
        user_location: {latitude: $routeParams['customer_latitude'], longitude: $routeParams['customer_longitude']},
        marker_index: 0,
        start_point: new google.maps.LatLng($routeParams['customer_latitude'],$routeParams['customer_longitude']),
        end_point: new google.maps.LatLng(1,2),
        zoom:13
    }

    $scope.get_individual_outlet = function(){
        $http({
            method: 'GET',
            url: domain+'individual_outlet.json',
            params: {
                customer_uuid: $cookies['customer_uuid'],
                id: $routeParams['id']
            }
        })
        .success(function(response){
            $scope.posters = response.outlet;
            $scope.distance = $routeParams['distance'];
            $scope.title_brand_name = response.outlet[0].brand_name;
        })
    }
})
