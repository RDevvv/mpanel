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

    $scope.listing_form = function(){
        $location.search('search','all');
        $location.search('location',$scope.topsearch);
    }

    $scope.category_form = function(){
        $location.search('search',$scope.category);
    }

    $scope.view_button = function(){
        if($location.path()=='/outlet_view')
            return 'loc';
        else
            return 'outlet';
    }

    $scope.map_view_link = function(){
        if($location.path()=='/outlet_view')
            new_location = 'map_view';
        else
            new_location = 'outlet_view';
        $location.url(new_location+'?location='+$routeParams['location']+'&search='+$routeParams['search']+'&latitude='+$routeParams['latitude']+'&longitude='+$routeParams['longitude']+'&view='+$routeParams['view']);
    }

    $scope.disable_button = function(search){
        console.log(search);
        return true;
    }


    $scope.show_top_menu = function(){
        angular.element('#header').removeClass('hide');
        angular.element('#top_search').removeClass('hide');
    }

    hide_top_menu = function(){
        if(($location.url()=='/')||($location.url()=='/home')){
            angular.element('#header').addClass('hide');
            angular.element('#top_search').addClass('hide');
        }
    }
    hide_top_menu();
}])
