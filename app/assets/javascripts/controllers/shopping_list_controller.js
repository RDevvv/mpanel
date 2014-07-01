app.controller('ShoppingListController', function($scope, ipCookie, $http){
    $http({
        method  : 'GET',
        url     : domain+'/get_customer_keywords',
        params  : {
            customer_uuid: ipCookie('customer_uuid')
        }
    }).success(function(data){
        $scope.tags = data;
    });


    $scope.load_keywords = function(query_keyword){
        return $http.get(domain+"/get_keywords?query="+query_keyword);
    }

    $scope.save_keywords = function(){
    }

})
