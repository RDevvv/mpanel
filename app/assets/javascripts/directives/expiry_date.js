app.directive('expiryDate', function($filter){
    return{
        restrict: 'E',
        replace: true,
        template: "<div class='distance-div-below2'>{{expiry_date}}</div>",
        link: function(scope){
            if(Date(scope.poster.ad_expiry_date) < Date('01-01-2050')){
                scope.expiry_date = '';
            }
            else{
                formatted_date = $filter('date')(scope.poster.ad_expiry_date, 'shortDate');
                console.log(formatted_date);
                scope.expiry_date = "Ends: "+formatted_date;
            }
        }
    }
})
