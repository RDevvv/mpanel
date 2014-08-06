var arrr = [];
app.controller('SingleOutletController', function($scope, $http, $routeParams, $cookies, AdOutlets){
    $scope.map = {
        user_icon: 'http://shoffr.com/assets/user_pin.png',
        icon: 'http://maps.google.com/mapfiles/markerA.png',
        center: {latitude: $routeParams['customer_latitude'], longitude: $routeParams['customer_longitude']},
        user_location: {latitude: $routeParams['customer_latitude'], longitude: $routeParams['customer_longitude']},
        marker_index: 0,
        zoom:13
    }

    $scope.get_individual_outlet = function(){
        $scope.poster = _.find(AdOutlets.posters,function(poster){return poster.outlet_id==$routeParams.id})
        if(typeof($scope.poster)=='undefined')
        $http({
            method: 'GET',
            url: domain+'individual_outlet.json',
            params: {
                customer_uuid: $cookies['customer_uuid'],
                id: $routeParams['id']
            }
        })
        .success(function(response){
            $scope.poster = response.outlet[0];
            $scope.distance = $routeParams['distance'];
            $scope.products = response.products;
            $scope.title_brand_name = response.outlet[0].brand_name;
        })
    }

    $scope.init = function(){
        $scope.customer_latitude = $routeParams.customer_latitude;
        $scope.customer_longitude= $routeParams.customer_longitude;
        $scope.width = window.screen.availWidth;
    }
    $scope.init();
})
