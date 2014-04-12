app.controller('SingleOutletController', function($scope, $http, $routeParams){
    $http({
        method: 'GET',
        url: 'individual_outlet.json',
        params: {
            id: 1//$routeParams['outlet_id']
        }
    })
    .success(function(response){
        $scope.posters = response.outlet;
    })

    $scope.map = {
        user_icon: 'http://localhost:3000/assets/user_pin.png',
        icon: 'http://maps.google.com/mapfiles/markerA.png',
        center: {latitude: $routeParams['customer_latitude'], longitude: $routeParams['customer_longitude']},
        user_location: {latitude: 12.8, longitude: 72.8},
        marker_index: 0,
        zoom:13
    }
})
