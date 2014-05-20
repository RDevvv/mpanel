app.directive('resendLink', function($location, $routeParams, $cookies){
    return{
        restrict: 'E',
        replace: true,
        template:
          "<div class='label-subtxt2'><a class='{{resend_class}}' href='' ng-click='resend_verification_code()'>Resend verification code</a><span class='hide' ng-class='{{verified_class}}'>Number verified!</span></div>",
        link: function(scope){
            if($cookies.mobile_number=='verified'){
                scope.resend_class = 'hide';
            }
            else
                scope.verified_class = 'hide';
        }
    }
})
