app.controller('ProfileController',function($scope, $http, $cookies, $location, $timeout, UserProfile){
    $scope.number_submit_message = false;
    $scope.verification_code_submit_message = false;
    $http({
        method: 'GET',
        url: domain+'get_profile.json',
        params: {
            mobile_number: $scope.mobile_number,
            customer_uuid: $cookies['customer_uuid']
        }
    }).success(function(data){
        $scope.name = data['name'];
        $scope.mobile_number = data['mobile_number'];
    })

    $scope.check_size = function(){
        if($scope.mobile_number.length==10){
            $http({
                method: 'POST',
                url: domain+"/get_mobile_number.json",
                params: {
                    mobile_number: $scope.mobile_number,
                    customer_uuid: $cookies['customer_uuid']
                }
            }).success(function(data){
                $scope.phone_number_message = 'vivek';
                $scope.number_submit_message = true;
            });
        }
    }

    $scope.profile_submit = function(){
        console.log('profile submit');
        $http({
            url: domain+"/check_verification_code.json",
            method: 'POST',
            params: {
                verification_code: $scope.verification_code,
                customer_uuid: $cookies['customer_uuid']
            }
        }).success(function(data){
            if(data["verified"]==true){
                $scope.verification_message = 'Your number is verified, redirection to home page ...';
                $timeout(function(){
                    $location.path('/home')
                },2000);
            }
            else
                $scope.verification_message = 'Please enter a correct verification code';
        });
        $scope.verification_code_submit_message = true;
    }

})
