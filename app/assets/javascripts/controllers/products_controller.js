app.controller('ProductController',function($scope,$http){
    $scope.init = function(){
        $http({
            method: 'POST',
            url: domain+'fetch_products.json'
        })
    }

    $scope.init();
})
