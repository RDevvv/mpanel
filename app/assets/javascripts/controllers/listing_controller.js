app.controller('ListingController', function($scope, $http, $routeParams, $cookies, getOutlet, $location){
    $scope.page = 0;
    $scope.no_more_results = false;
    $scope.change_icon =true;
    $scope.enabled= false;

    $scope.map = {
        user_icon: 'http://www.gullakmaster.com/assets/user_pin.png',
        icon: 'http://maps.google.com/mapfiles/markerA.png',
        center: {latitude: 12.8, longitude: 72.8},
        marker_index: 0,
        zoom:13,
    }

    $scope.verified = function(){
        if($cookies.mobile_number=='verified')
            return true;
        else
            return false;
    }

    $scope.fetch_posters = function(){
        $scope.page++;
        $scope.enabled= true;
        if($scope.no_more_results == false){
            $http({
                method: 'GET',
                url   : domain+'outlet_listing.json',
                params: {
                    page: $scope.page,
                    search: $routeParams['search'],
                    filter: $routeParams['filter'],
                    latitude: $routeParams['latitude'],
                    longitude: $routeParams['longitude'],
                    view: 'outlet_listing',
                    location: $routeParams['location']
                }
            }).success(function(data){
                $scope.show_top_menu();
                if(typeof($scope.posters)=='undefined'&&data.length==0){
                    $scope.no_more_results = true;
                }
                if(typeof($scope.posters)=='undefined'){
                    $scope.posters = [];
                    $scope.enabled=false;
                }
                for(i=0;i<data.length;i++){
                    $scope.posters.push(data[i]);
                }
                if($scope.posters.length>0){
                    $scope.map.center = {latitude: $scope.posters[0].customer.latitude, longitude: $scope.posters[0].customer.longitude};
                    $scope.enabled=false;
                }
            })
        }
    }

    $scope.show_top_menu = function(){
        angular.element('#header').removeClass('hide');
        angular.element('#top_search').removeClass('hide');
    }

    $scope.generate_markers = function(){
        $scope.map.marker_index++;
        //var link = 'http://maps.google.com/mapfiles/marker'+String.fromCharCode($scope.map.marker_index+65)+'.png';
        //return link;
    }

    $scope.distance_filter = function(filter){
        angular.element('nav#menu').trigger('close');
        $location.search('filter',filter);
    }

    $scope.unlock = function(brand_name,ad_id, outlet_id, sms_text, index) {
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
        ($scope.posters[index].ad_usage++);
        $http({
            method: 'POST',
            url   : domain+'set_sms_data.json',
            params: {
                customer_uuid: $cookies.customer_uuid,
                ad_id: ad_id,
                outlet_id: outlet_id,
                misc_sms: false
            }
        })
    }


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
            url: domain+'get_button_click.json',
            params: {
                customer_uuid: $cookies.customer_uuid,
                ad_id: ad_id,
                outlet_id: outlet_id,
                button_class: button_class,
                current_link: current_link
            }
        })
    }

    $scope.show_modal = function(){
        if($cookies['mobile_number']=='not_verified'||$cookies['mobile_number']=='true'){
            angular.element('#verification').modal('show');
        }
        else if($cookies['mobile_number']=='false'){
            angular.element('#mobile-number').modal('show');
        }
    }

    $scope.poster_share = function(outlet_id){
        if($cookies['mobile_number']=='verified'){
            $.pnotify({ title: ' ', text: 'You will receive a SMS from Shoffr shortly. Kindly share the link with your friends',
                      closer_hover: false,
                      sticker_hover: false,
                      animate_speed: 'fast',
                      icon: false,
                      addclass: 'stack-topleft',
                      opacity: .9
            });
            $http({
                method: 'POST',
                url   : domain+'set_sms_data.json',
                params: {
                    customer_uuid: $cookies.customer_uuid,
                    outlet_id: outlet_id,
                    poster_share: true,
                    misc_sms: true
                }
            })
        }
        else
            angular.element('#popup_share').modal('show');
    }
})

