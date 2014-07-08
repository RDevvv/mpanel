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

    $scope.remove_tag = function(){
        console.log('vivek');
    }

    $scope.add_tag = function(tag){
        $http({
            method: 'POST',
            url   : domain+'customer_keywords.json',
            params: {
            customer_uuid: ipCookie('customer_uuid'),
            keyword: tag.text
            }
        })
    }

    $scope.save_keywords = function(){
    }

})
