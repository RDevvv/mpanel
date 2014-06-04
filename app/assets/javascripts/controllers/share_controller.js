app.controller('ShareController', function($scope, $cookies, $http, $location){
    $scope.top_share = function(){
        if($cookies['mobile_number']=='verified'){
            new PNotify({ title: ' ', text: 'You will receive a SMS from Shoffr shortly. Kindly share the link with your friends'});
            $http({
                method: 'POST',
                url   : domain+'set_sms_data.json',
                params: {
                    customer_uuid: $cookies.customer_uuid,
                    misc_sms: true
                }
            })
        }
        else
            angular.element('#mobile-number').modal('show');
    }
})
