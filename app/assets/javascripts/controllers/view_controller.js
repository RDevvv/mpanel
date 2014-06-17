app.controller('ViewController', function($scope, $location){
    $scope.$on("$routeChangeSuccess", function(event, current, previous) {
        var previousCtrl = previous && previous.$$route && previous.$$route.controller;
        if (previousCtrl === "ListingController") {
            $scope.animationStyle = "slideLeft";
        } else if (previousCtrl === "SingleOutletController") {
            $scope.animationStyle = "slideRight";
        }
        $scope.$apply();
    });

    $scope.view_class = function(){
        if($location.$$path == '/deals/outlets')
            view = 'outlet_view';
        else if ($location.$$path == '/deals/shop')
            view = 'deal_shop';
        else if($location.$$path == '/home')
            view = 'home';
        return $scope.animationStyle+' '+view;
    }
})
