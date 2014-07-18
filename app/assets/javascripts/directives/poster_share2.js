app.directive('posterShare2', function(){
    return{
        restrict: 'E',
        replace: true,
        templateUrl: "templates/poster_share2.html",
        link: function(scope){
            scope.app_type= app_type;
        }
    }
})
