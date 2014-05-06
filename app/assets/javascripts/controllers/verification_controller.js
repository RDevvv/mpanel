app.controller('VerificationController',function($scope, $http, $cookies, $location){
    $scope.enter_number = function(){
        $http({
            method: 'POST',
            url: "/get_mobile_number.json",
            params: {
                mobile_number: $scope.mobile_number,
                customer_uuid: $cookies['customer_uuid']
            }
        }).success(function(data){
            console.log(data);
            if(data["mobile_number"]==1){
                $('#mobile-number').modal('hide');
                $('#verification').modal('show');
            }
            else if(data["mobile_number"]=="exist"){
                if($.cookie('mobile_number')=='not_verified'){
                    $('#verification').modal('show');
                    $('#mobile-number').modal('hide');
                }
                else{
                    $.pnotify({ title: 'Welcome back', text: '', closer_hover: false, sticker_hover: false, icon: false, opacity: .9 });
                    $location('search','all');
                    $('#mobile-number').modal('hide');
                }
            }
            else{
                $.pnotify({ title: '', text: 'Enter a valid mobile number', closer_hover: false, sticker_hover: false, icon: false, opacity: .9 });
            }
        });
    }
})
