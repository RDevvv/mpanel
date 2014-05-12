app.factory('UserProfile', function($http){
    return{
        name:  'vivek varade',
        mobile_number:  9503467486,
        fetch_profile: function(){
            console.log('fetched');
            return $http({
                method: 'POST',
                url: 'get_mobile_number.json',
                params: {
                    mobile_number: $scope.mobile_number,
                    customer_uuid: $cookies['customer_uuid']
                }
            }).success({

            })
        }
    }
})
