app.directive('topHeader', function($location, $routeParams){
    return{
        restrict: 'E',
        replace: true,
        template: '<a href="#/home">{{header}}</a>',
        link: function(scope){
            console.log('executeddddddddddddddddd');
            if($location.path()=='/deals/shop')
                scope.header = 'deal-shop';
            else
                scope.header = 'shoffr';
        }
    }
})
