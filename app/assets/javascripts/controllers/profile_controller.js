app.controller('ProfileController',function($scope, $http, $cookies, UserProfile){
    $http({
        method: 'GET',
        url: 'get_profile.json',
        params: {
            mobile_number: $scope.mobile_number,
            customer_uuid: $cookies['customer_uuid']
        }
    }).success(function(data){
        $scope.name = data['name'];
        $scope.mobile_number = data['mobile_number'];
    })

    $scope.profile_submit = function(){
        console.log('profile_submitted');
        $http({
            method: 'POST',
            url: 'get_profile.json',
            params: {
                mobile_number: $scope.mobile_number,
                customer_uuid: $cookies['customer_uuid']
            }
        }).success(function(data){
            $scope.name = data['name'];
            $scope.mobile_number = data['mobile_number'];
        })
    }
})
