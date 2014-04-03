app.controller('HomeController', ['$scope', '$http', '$routeParams', '$cookies', '$location', function($scope, $http, $routeParams, $cookies, $location){
    $scope.home_submit = function(location, latitude, longitude){
        if($cookies['mobile_number']=='undefined'||$cookies['mobile_number']=='false'){
            angular.element('#mobile-number').modal('show');
        }
        else if($cookies['mobile_number']=='not_verified'){
            angular.element('#verification').modal('show');
        }
        else{
            $location.url('/outlet_view?search=all&location='+location+'&latitude='+latitude+'&longitude='+longitude+'&view=outlet_listing')
        }
    }

    $scope.show_top_menu = function(){
        angular.element('#header').removeClass('hide');
        angular.element('#top_search').removeClass('hide');
    }

    hide_top_menu = function(){
        if($location.url()=='/'){
            angular.element('#header').addClass('hide');
            angular.element('#top_search').addClass('hide');
        }
    }
    hide_top_menu();
}])
