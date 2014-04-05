app.controller('ListingController', ['$scope', '$http', '$routeParams', '$cookies', 'getOutlet', '$location', function($scope, $http, $routeParams, $cookies, getOutlet, $location){
    getOutlet.fetch_outlets(function(response_data){
        $scope.posters = response_data;
    });

    $scope.verified = function(){
        if($cookies.mobile_number=='verified')
            return true;
    }

    $scope.listing_form = function(){
        $location.search('search','all');
        $location.search('location',$scope.topsearch);
    }

    $scope.category_form = function(){
        $location.search('search',$scope.category);
    }

    $scope.map_view_link = function(){
        if($location.path()=='/outlet_view')
            new_location = 'map_view';
        else
            new_location = 'outlet_view';
        $location.url(new_location+'?location='+$routeParams['location']+'&search='+$routeParams['search']+'&latitude='+$routeParams['latitude']+'&longitude='+$routeParams['longitude']+'&view='+$routeParams['view']);
    }

    $scope.distance_filter = function(filter){
        angular.element('nav#menu').trigger('close');
        $location.search('filter',filter);
    }

    $scope.unlock = function (brand_name,ad_id, outlet_id) {
        $http({
            method: 'POST',
            url   : 'set_sms_data.json',
            params: {
                customer_uuid: $cookies.customer_uuid,
                ad_id: ad_id,
                outlet_id: outlet_id
            }
        })
        $.pnotify({
            title: brand_name+' - Offer sent',
            text: 'text',
            sticker_hover: false,
            closer_hover: false,
            animate_speed: 'fast',
            icon: false,
            addclass: 'stack-topleft',
            opacity: .9
        });
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
}])

