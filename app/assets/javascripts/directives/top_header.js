app.directive('topHeader', function($location, $routeParams){
    return{
        restrict: 'E',
        replace: true,
        template: '<div><a href="javascript:history.back()" class="{{back_link}}">&nbsp;</a><a href="#/home">{{header}}</a></div>',
        link: function(scope){
            scope.$on('$locationChangeSuccess', function(){
                if($location.path()=='/deals/shop'){
                    scope.header = $location.search().brand_name;
                    scope.back_link= 'backpage';
                }
                else if($location.path()=='/profile'){
                    scope.header = 'My profile';
                    scope.back_link= 'backpage';
                }
                else{
                    scope.header = 'shoffr';
                    scope.back_link = 'hide'
                }
            });
        }
    }
})
