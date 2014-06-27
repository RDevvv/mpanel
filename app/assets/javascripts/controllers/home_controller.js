app.controller('HomeController', function($scope, $rootScope, $routeParams, $cookies, $location, $route, UrlContent, snapRemote, AdOutlets, FilterState){

    $scope.home_submit = function(){
        if(($cookies['mobile_number']!='verified')&&(app_type=='html5')){
            UrlContent.location = $scope.searchh;
            UrlContent.latitude = $scope.latitude;
            UrlContent.longitude= $scope.longitude;
            angular.element('#mobile-number').modal('show');
        }
        else{
            UrlContent.location = $scope.searchh;
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
        snapRemote.close();
        $location.search('search','all');
        $location.search('location',$scope.topsearch);
        $location.search('latitude',0);
        $location.search('longitude',0);
    }

    $scope.category_form = function(){
        if($scope.submit_type=='filter'){
            $location.search('search','all');
            FilterState.hide_filter=true;
        }
        else{
            $location.path('/deals/outlets');
            $location.search('search',$scope.category);
            FilterState.hide_filter=false;
        }
    }

    $scope.set_attribute = function(type){
        AdOutlets.outlet_ids =[];
        AdOutlets.posters =[];
        if(type=='filter'){
            $scope.category='all';
            FilterState.submit_type='filter';
        }
        else
            FilterState.submit_type='search';
    }


    $scope.set_class = function(){
        if(FilterState.submit_type!='filter'&&FilterState.hide_filter==false)
            return 'non_grey_filter';
        else
            return 'non_grey_filter hide';
    }

    $scope.profile_redirection = function(){
        $rootScope.$on('$routeChangeStart', function(){
            if(($location.path()=='/'||$location.path()=='/home')&&$cookies.mobile_number!='verified'&&app_type=='native')
                $location.path('/profile');
        })
    }
    $scope.profile_redirection();

    window.onscroll = function(){snapRemote.close()}
})
