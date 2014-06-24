app.controller('ShareController', function($scope, $cookies, $http, $location){
    $scope.top_share = function(brand_name){
        if($cookies['mobile_number']=='verified'){
            $http({
                method: 'POST',
                url   : domain+'set_sms_data.json',
                params: {
                    customer_uuid: $cookies.customer_uuid,
                    brand_name: brand_name,
                    whatsapp_share: true,
                    misc_sms: true
                }
            }).success(function(data){
                if(app_type=='native')
                    window.plugins.socialsharing.shareViaWhatsApp(data,null,null,success,function(msg){window.plugins.socialsharing.shareViaSMS(data,null,success,failure)})
                else{}
            })
        }
        else
            angular.element('#mobile-number').modal('show');
    }
})
