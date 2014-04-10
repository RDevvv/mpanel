app.controller('ListingController', function($scope, $http, $routeParams, $cookies, getOutlet, $location){
    $scope.verified = function(){
        if($cookies.mobile_number=='verified')
            return true;
    }


    $scope.fetch_posters = function(){
        $scope.page++;
        $scope.disabled = true;
        if($scope.no_more_results == false){
            $http({
                method: 'GET',
                url   : 'outlet_listing.json',
                params: {
                    page: $scope.page,
                    search: 'all',
                    view: 'outlet_listing',
                    location: 'bandra'
                }
            }).success(function(data){
                if(typeof(data.length)=='undefined')
                    $scope.no_more_results = true;
                if(typeof($scope.posters)=='undefined'){
                    $scope.posters = [];
                }
                for(i=0;i<data.length;i++){
                    $scope.posters.push(data[i]);
                }
                $scope.disabled =false;
            })
        }
    }

    $scope.center = function(){
        var center = {latitude: 12, longitude: 72};
        return center;
    }

    $scope.map = {
        icon: 'http://localhost:3000/assets/favicon.ico',
        center: $scope.center(),
        zoom:10
    }

    $scope.page = 0;
    $scope.no_more_results = false;
    $scope.disabled = false;

    $scope.distance_filter = function(filter){
        angular.element('nav#menu').trigger('close');
        $location.search('filter',filter);
    }


    $scope.unlock = function(brand_name,ad_id, outlet_id, sms_text) {
        $.pnotify({
            title: brand_name+' - Offer sent',
            text: sms_text,
            sticker_hover: false,
            closer_hover: false,
            animate_speed: 'fast',
            icon: false,
            addclass: 'stack-topleft',
            opacity: .9
        });
        $scope.change_icon = false;
        $http({
            method: 'POST',
            url   : 'set_sms_data.json',
            params: {
                customer_uuid: $cookies.customer_uuid,
                ad_id: ad_id,
                outlet_id: outlet_id,
                misc_sms: false
            }
        })
    }


    $scope.change_icon =true; //= function(element){

    $scope.view_ad = function(brand_name, title, sms_text){
        $.pnotify({ title: brand_name+' - '+title, text: sms_text,
                  closer_hover: false,
                  sticker_hover: false,
                  animate_speed: 'fast',
                  icon: false,
                  addclass: 'stack-topleft',
                  opacity: .9
        });
    }

    $scope.tracking = function(ad_id,outlet_id,button_class, current_link){
        $http({
            method: 'POST',
            url: 'get_button_click.json',
            params: {
                customer_uuid: $cookies.customer_uuid,
                ad_id: ad_id,
                outlet_id: outlet_id,
                button_class: button_class,
                current_link: current_link
            }
        })
    }
})

