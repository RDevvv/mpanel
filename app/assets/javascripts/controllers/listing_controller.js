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
                    search: $routeParams['search'],
                    filter: $routeParams['filter'],
                    view: 'outlet_listing',
                    location: $routeParams['location']
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
                $scope.map.center = {latitude: $scope.posters[0].customer.latitude, longitude: $scope.posters[0].customer.longitude};
                $scope.map.user_location = {latitude: $scope.posters[0].customer.latitude, longitude: $scope.posters[0].customer.longitude};
                $scope.disabled =false;
            })
        }
    }

    $scope.map = {
        user_icon: 'http://localhost:3000/assets/user_pin.png',
        icon: 'http://maps.google.com/mapfiles/markerA.png',
        center: {latitude: 12.8, longitude: 72.8},
        user_location: {latitude: 12.8, longitude: 72.8},
        marker_index: 0,
        zoom:13
    }

    $scope.generate_markers = function(){
        $scope.map.marker_index++;
        //var link = 'http://maps.google.com/mapfiles/marker'+String.fromCharCode($scope.map.marker_index+65)+'.png';
        //console.log($scope.map.marker_index);
        //return link;
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

