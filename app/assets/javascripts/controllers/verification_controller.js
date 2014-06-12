app.controller('VerificationController',function($scope, $http, $location, UrlContent, ipCookie){
    $scope.enter_number = function(){
        $http({
            method: 'POST',
            url: domain+"/get_mobile_number.json",
            params: {
                mobile_number: $scope.mobile_number,
                customer_uuid: ipCookie('customer_uuid')
            }
        }).success(function(data){
                    angular.element('#mobile-number').modal('hide');
            if(data["mobile_number"]==1){
                $('#mobile-number').modal('hide');
                $('#verification').modal('show');
            }
            else if(data["mobile_number"]=="exist"){
                if(data['verified']==true){
                    new PNotify({ title: 'Welcome back'});
                    ipCookie('mobile_number','verified',{expires: 365});
                    ipCookie('customer_uuid',data['customer_uuid'],{expires: 365});
                    $location.url('/deals/outlets?search=all&location='+UrlContent.location+'&latitude='+UrlContent.latitude+'&longitude='+UrlContent.longitude);
                    angular.element('#mobile-number').modal('hide');
                }
                else{
                    $('#verification').modal('show');
                    angular.element('#mobile-number').modal('hide');
                }
            }
            else{
                new PNotify({ title: '', text: 'Enter a valid mobile number'});
            }
        });
    }

    $scope.enter_verification_code = function(){
        $http({
            url: domain+"/check_verification_code.json",
            //dataType: 'text',
            params: {
                verification_code: $scope.verification_code,
                customer_uuid: ipCookie('customer_uuid')
            },
            method: 'POST'
        }).success(function(data){
            if(data["verified"]==true)
                {
                    $('#verification').modal('hide');
                    new PNotify({ title: 'Your account is verified', text: ''});
                    ipCookie('mobile_number','verified',{expires: 365});
                    $location.url('/deals/outlets?search=all&location='+UrlContent.location+'&latitude='+UrlContent.latitude+'&longitude='+UrlContent.longitude);
                }
                else{
                    new PNotify({ title: 'Please enter correct verification code.'});
                }
        });
        return false; // prevents normal behaviour
    }
})
