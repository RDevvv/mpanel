app.directive('locationBar',function($routeParams){
    return{
        restrict: 'E',
        replace: true,
        templateUrl: 'templates/location_bar.html',
        link: function(scope){
            scope.user_location = $routeParams.location;
        }
    }
})
