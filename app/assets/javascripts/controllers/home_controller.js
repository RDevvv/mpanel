app.controller('HomeController', function($scope, $rootScope, $http, $routeParams, $cookies, $location, $route, UrlContent, snapRemote, AdOutlets){
    $scope.hide_filter = true;

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
        if($scope.submit_type=='filter')
            $location.search('search','all');
        else
            $location.search('search',$scope.category);
    }

    $scope.set_attribute = function(type){
            AdOutlets.outlet_ids =[];
            AdOutlets.posters =[];
        $scope.hide_filter = false;
        if(type=='filter'){
            $scope.category='';
            $scope.submit_type='filter';
        }
        else{
            $scope.submit_type='search';
        }
    }


    $scope.set_class = function(){
        if($scope.submit_type!='filter'&&$scope.hide_filter==false)
            return 'non_grey_filter';
        else
            return 'non_grey_filter hide';
    }

    $scope.top_search_class = function(){
        if($location.path()=='/deals/outlets'||$location.path()=='/deals/shop')
            return 'span12';
        else
            return 'hide';
    }

    $scope.top_menu_class = function(){
        if($location.path()=='/deals/outlets'||$location.path()=='/profile'||$location.path()=='/deals/shop')
            return '';
        else
            return 'hide';
    }

    $scope.right_buttons_class = function(){
        if($location.path()=='/profile')
            return 'hide';
        else
            return 'right-icons';
    }

    $scope.vvv = function(brand_name){
        $http({
            method: 'POST',
            url   : domain+'set_sms_data.json',
            params: {
                customer_uuid: $cookies.customer_uuid,
                whatsapp_share: true,
                brand_name: brand_name,
                misc_sms: true
            }
        }).success(function(data){
            if(app_type=='native')
                window.plugins.socialsharing.shareViaWhatsApp(data,null,null,success,function(msg){window.plugins.socialsharing.shareViaSMS(data,null,success,failure)})
        });
    }

    $scope.profile_redirection = function(){
        $rootScope.$on('$routeChangeStart', function(){
            if(($location.path()=='/'||$location.path()=='/home')&&$cookies.mobile_number!='verified'&&app_type=='native')
                $location.path('/profile');
        })
    }
    $scope.profile_redirection();
})
