app.controller('HomeController', ['$scope', '$http', '$routeParams', '$cookies', '$location', function($scope, $http, $routeParams, $cookies, $location){
    $scope.home_submit = function(){
        if($cookies['mobile_number']=='undefined'||$cookies['mobile_number']=='false'){
            angular.element('#mobile-number').modal('show');
        }
        else if($cookies['mobile_number']=='not_verified'){
            angular.element('#verification').modal('show');
        }
        else{
            $location.url('/deals/outlets?search=all&location='+$scope.searchh+'&latitude='+$scope.latitude+'&longitude='+$scope.longitude);
        }
    }

    $scope.filter_class = function(){
        if($routeParams.search=='all'){
            return 'btn grey_filter';
        }
        else
            return 'btn non_grey_filter';
    }

    $scope.listing_form = function(){
        $location.search('search','all');
        $location.search('location',$scope.topsearch);
    }

    $scope.category_form = function(){
        //if($routeParams.search!='all'){
        //}
        $location.search('search',$scope.category);
    }


    $scope.view_button = function(){
        if($location.path()=='/deals/shop')
            return 'hidden';
        else if($location.path()=='/deals/outlets')
            return 'loc';
        else
            return 'outlet';
    }

    $scope.map_view_link = function(){
        if($location.path()=='/deals/outlets')
            new_location = 'deals/map';
        else
            new_location = 'deals/outlets';
        $location.url(new_location+'?location='+$routeParams['location']+'&search='+$routeParams['search']+'&latitude='+$routeParams['latitude']+'&longitude='+$routeParams['longitude']+'&view='+$routeParams['view']);
    }

    $scope.disable_button = function(search){
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
