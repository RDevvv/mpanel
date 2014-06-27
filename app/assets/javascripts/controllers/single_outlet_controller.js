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
    }
})
