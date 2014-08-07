app.controller('ProductController',function($scope,$http,$routeParams, $cookies){
    $scope.init = function(){
        $http({
            method: 'get',
            url: domain+'individual_product.json',
            params:{
                id: $routeParams.id
            }
        }).success(function(data){
            $scope.product = data.product;
            $scope.comments = data.comments;
        })
    }

    $scope.submit_comment = function(){
        angular.element('.comment_box').append("<div class='selfie-comment'><span>You:</span>"+$scope.new_comment+"</div>");
        $http({
            method: 'post',
            url: 'save_comment.json',
            params:{
                product_id: $routeParams.id,
                customer_uuid: $cookies.customer_uuid,
                comment: $scope.new_comment
            }
        })
    }

    $scope.submit_like = function(){
        $http({
            method: 'post',
            url: 'save_like.json',
            params: {
                product_id: $routeParams.id,
                customer_uuid: $cookies.customer_uuid
            }
        })
        $scope.product.product_likes_count+=1
    }

    $scope.init();
})
