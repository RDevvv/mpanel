app.directive('posterShare', function(){
    return{
        restrict: 'E',
        replace: true,
        templateUrl: "templates/poster_share.html",
        link: function(scope){
            scope.app_type= app_type;
        }
    }
})
