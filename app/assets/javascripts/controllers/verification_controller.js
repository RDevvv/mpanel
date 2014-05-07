app.controller('VerificationController',function($scope, $http, $cookies, $location, UrlContent){
    $scope.enter_number = function(){
        $http({
            method: 'POST',
            url: "/get_mobile_number.json",
            params: {
                mobile_number: $scope.mobile_number,
                customer_uuid: $cookies['customer_uuid']
            }
        }).success(function(data){
                    angular.element('#mobile-number').modal('hide');
            if(data["mobile_number"]==1){
                $('#mobile-number').modal('hide');
                $('#verification').modal('show');
            }
            else if(data["mobile_number"]=="exist"){
                if(data['verified']==true){
                    $.pnotify({ title: 'Welcome back', text: '', closer_hover: false, sticker_hover: false, icon: false, opacity: .9 });
                    $location.url('/deals/outlets?search=all&location='+UrlContent.location+'&latitude='+UrlContent.latitude+'&longitude='+UrlContent.longitude);
                    angular.element('#mobile-number').modal('hide');
                }
                else{
                    $('#verification').modal('show');
                    angular.element('#mobile-number').modal('hide');
                }
            }
            else{
                $.pnotify({ title: '', text: 'Enter a valid mobile number', closer_hover: false, sticker_hover: false, icon: false, opacity: .9 });
            }
        });
    }

    $scope.enter_verification_code = function(){
        $http({
            url: "/check_verification_code.json",
            //dataType: 'text',
            params: {
                verification_code: $scope.verification_code,
                customer_uuid: $cookies['customer_uuid']
            },
            method: 'POST'
        }).success(function(data){
            if(data["verified"]==true)
                {
                    $('#verification').modal('hide');
                    $.pnotify({ title: 'Your account is verified', text: '', closer_hover: false, sticker_hover: false, icon: false});
                    $location.url('/deals/outlets?search=all&location='+UrlContent.location+'&latitude='+UrlContent.latitude+'&longitude='+UrlContent.longitude);
                }
                else{
                    $.pnotify({ title: 'Please enter correct verification code.', text: '', closer_hover: false, sticker_hover: false, icon: false});
                }
        });
        return false; // prevents normal behaviour
    }
})
