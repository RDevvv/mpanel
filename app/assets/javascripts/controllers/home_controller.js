app.controller('HomeController', ['$scope', '$http', '$routeParams', '$cookies', '$location', function($scope, $http, $routeParams, $cookies, $location){
    $scope.home_submit = function(location, latitude, longitude){
        $location.url('/outlet_view?search=all&location='+location+'&latitude='+latitude+'&longitude='+longitude+'&view=outlet_listing')
    }

    $scope.show_top_menu = function(){
        console.log('within show_top_menu');
            angular.element('#header').removeClass('hide');
            angular.element('#top_search').removeClass('hide');
    }

    hide_top_menu = function(){
        console.log('within hide_top_menu');
        if($location.url()=='/'){
            angular.element('#header').addClass('hide');
            angular.element('#top_search').addClass('hide');
        }
    }
    hide_top_menu();
}])
