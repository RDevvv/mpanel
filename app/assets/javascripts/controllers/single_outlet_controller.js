var arrr = [];
app.controller('SingleOutletController', function($scope, $http, $routeParams, $cookies, AdOutlets, Restangular){

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
      var products = Restangular.one('accounts',account_id).one('brands', $scope.poster.brand_id).all('products');
      products.getList().then(function(products){
            $scope.products = products;
      });
    }

    $scope.init = function(){
        $scope.customer_latitude = $routeParams.customer_latitude;
        $scope.customer_longitude= $routeParams.customer_longitude;
        $scope.width = window.screen.availWidth;
    }
    $scope.init();
})
