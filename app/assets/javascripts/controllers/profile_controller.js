app.controller('ProfileController',function($scope, $http, $location, $timeout, UserProfile, ipCookie){
    $scope.number_submit_message = false;
    $scope.verification_code_submit_message = false;

    $scope.init = function(){
        if(app_type=='native'){
            $http({
                method: 'POST',
                url: domain+'check_app_cookies.json',
                params:{
                    customer_uuid: ipCookie('customer_uuid')
                }
            }).success(function(data){
                if(data['customer']!=null){
                    ipCookie('customer_uuid',data['customer']['uuid'], {expires: 365});
                    $scope.mobile_number = data['customer']['mobile_number'];
                    $scope.name= data['customer']['name'];
                }
            })
        }
    }

    $scope.get_profile = function(){
        $http({
            method: 'GET',
            url: domain+'get_profile.json',
            params: {
                mobile_number: $scope.mobile_number,
                customer_uuid: ipCookie('customer_uuid')
            }
        }).success(function(data){
            $scope.name = data['name'];
            $scope.mobile_number = data['mobile_number'];
        })
    }

    $scope.check_size = function(){
        if(isNaN(parseInt($scope.mobile_number))){
            $scope.error_message = true;
        }
        else{
            $scope.error_message = false;
        }
        if($scope.mobile_number.length==10){
            $http({
                method: 'POST',
                url: domain+"get_mobile_number.json",
                params: {
                    mobile_number: $scope.mobile_number,
                    customer_uuid: ipCookie('customer_uuid')
                }
            }).success(function(data){
                ipCookie('customer_uuid',data.customer_uuid, {expires: 365});
                $scope.number_submit_message = true;
            });
        }
    }

    $scope.check_verification_code_size= function(){
        if($scope.verification_code.length == 4){
            $http({
                url: domain+"check_verification_code.json",
                method: 'POST',
                params: {
                    name: $scope.name,
                    verification_code: $scope.verification_code,
                    customer_uuid: ipCookie('customer_uuid')
                }
            }).success(function(data){
                if(data["verified"]==true){
                    $scope.verification_message = 'Your number is verified.';
                    ipCookie('mobile_number','verified',{expires: 365});
                    $scope.submit_button = true;
                }
                else
                    $scope.verification_message = 'Please enter a correct verification code';
            });
            $scope.verification_code_submit_message = true;
        }
    }

    $scope.profile_submit = function(){
        $location.path('/');
    }


    $scope.resend_verification_code = function(){
        $http({
            url: domain+"resend_verification_code.json",
            method: 'POST',
            params: {
                customer_uuid: ipCookie('customer_uuid')
            }
        }).success(function(){
            new PNotify({title: 'verification code sent.'});

        })
    }

    $scope.init();
})
