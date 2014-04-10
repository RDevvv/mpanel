app.controller('ShareController', function($scope, $cookies, $http){
    $scope.top_share = function(){
        if($cookies['mobile_number']=='verified'){
            $.pnotify({ title: ' ', text: 'You will receive a SMS from Shoffr shortly. Kindly share the link with your friends',
                      closer_hover: false,
                      sticker_hover: false,
                      animate_speed: 'fast',
                      icon: false,
                      addclass: 'stack-topleft',
                      opacity: .9
            });
            $http({
                method: 'POST',
                url   : 'set_sms_data.json',
                params: {
                    customer_uuid: $cookies.customer_uuid,
                    misc_sms: true
                }
            })
        }
        else
            angular.element('#popup_share').modal('show');
    }
})
