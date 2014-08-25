var arrr = [];
app.controller('SingleOutletController', function($scope, $http, $routeParams, $cookies, AdOutlets){

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
            $scope.title_brand_name = response.outlet[0].brand_name;
        })
    }

    $scope.fetch_products = function(){
        $http({
        method: 'get',
        url: 'get_products_by_outlet.json',
        params: {
            outlet_id: $routeParams.id
        }}).success(function(data){
            $scope.products = data.products;
        })
    }

    $scope.init = function(){
        $scope.customer_latitude = $routeParams.customer_latitude;
        $scope.customer_longitude= $routeParams.customer_longitude;
        $scope.width = window.screen.availWidth;
    }
    $scope.init();
})
