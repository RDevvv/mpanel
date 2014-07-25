app.controller('ShareController', function($scope, $cookies, $http, $location){
    $scope.top_share = function(){
        if(app_type=='native'){
            whatsapp_share = true;
        }
        else{
            new PNotify({ title: ' ', text: 'You will receive a SMS from Shoffr shortly. Kindly share the link with your friends'});
            whatsapp_share = false;
        }
        if($cookies['mobile_number']=='verified'){
            $http({
                method: 'POST',
                url   : domain+'set_sms_data.json',
                params: {
                    customer_uuid: $cookies.customer_uuid,
                    whatsapp_share: whatsapp_share,
                    misc_sms: true
                }
            }).success(function(data){
                if(app_type=='native')
                    window.plugins.socialsharing.shareViaWhatsApp(data,null,null,success,function(msg){window.plugins.socialsharing.shareViaSMS(data,null,success,failure)})
            })
        }
        else
            angular.element('#mobile-number').modal('show');
    }

    $scope.sweepstakes_share = function(){
        if($cookies.sweepstakes_modal ==undefined){
            setTimeout(function(){
                $cookies.sweepstakes_modal = true;
                angular.element('#myModal').modal('show');
            },20000)
        }
    }
    $scope.sweepstakes_share();
})
