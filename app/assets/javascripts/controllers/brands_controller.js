var vivek;
app.controller('BrandsController',function($scope, $routeParams, Restangular){
  var brand = Restangular.one('accounts',account_id).one('brands',$routeParams.brand_id)
  brand.get().then(function(single_brand){
    $scope.brand = single_brand;
  });
})
