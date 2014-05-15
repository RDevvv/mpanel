app.directive('topHeader', function($location, $routeParams){
    return{
        restrict: 'E',
        replace: true,
        template: '<div><a href="javascript:history.back()" class="backpage">&nbsp;</a><a href="#/home">{{header}}</a></div>',
        link: function(scope){
            scope.$on('$locationChangeSuccess', function(){
                if($location.path()=='/deals/shop'){
                    scope.header = $location.search().brand_name;
                    scope.back_link= $(scope.back_link);
                }
                else{
                    scope.header = 'shoffr';
                    scope.back_link = 'hide'
                }
            });
        }
    }
})
