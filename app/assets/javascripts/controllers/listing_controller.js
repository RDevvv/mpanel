app.controller('ListingController', function($scope, $http, $routeParams, $cookies, AdOutlets, $location){
    $scope.page = 0;
    $scope.no_more_results = false;
    $scope.no_results = false;
    $scope.change_icon =true;
    $scope.enabled= false;
    $scope.user_location = AdOutlets.user_location;

    if($routeParams.search!='all')
        $scope.category = $routeParams.search;

    $scope.fetch_posters = function(){
        if($routeParams.search == undefined){
            $routeParams.search = 'all';
            $routeParams.location = 'bandra'
            $routeParams.latitude = 0;
            $routeParams.longitude = 0;
            $routeParams.account_id = account_id;

            AdOutlets.user_location = 'bandra';
        }


        if($routeParams.search!='all'&&$routeParams.page==1){
            AdOutlets.posters =[];
        }
        if((AdOutlets.url_location==$routeParams.location)||(AdOutlets.url_location=='')){}
        else
            AdOutlets.posters =[];
        AdOutlets.url_location = $routeParams.location;
        $scope.posters = AdOutlets.posters;
        $scope.page++;
        $scope.enabled= true;
        $http({
            method: 'GET',
            url   : domain+'outlet_listing.json',
            params: {
                page: $scope.page,
                search: $routeParams['search'],
                filter: $routeParams['filter'],
                latitude: $routeParams['latitude'],
                longitude: $routeParams['longitude'],
                account_id: account_id,
                location: $routeParams['location']
            }
        }).success(function(data){
            if(typeof($scope.posters)=='undefined'){
                $scope.posters = [];
                $scope.enabled=false;
            }
            for(i=0;i<data.length;i++){
                if($routeParams.search!='all'){
                    AdOutlets.posters.push(data[i]);
                }
                else if(!_.contains(AdOutlets.outlet_ids,data[i].outlet_id)){
                    AdOutlets.posters.push(data[i]);
                    AdOutlets.outlet_ids.push(data[i].outlet_id);
                }
            }
            if(AdOutlets.first_poster_set ==false){
                AdOutlets.first_poster = data[0];
                AdOutlets.first_poster_set = true;
            }
            if($scope.posters.length>0){
                $scope.enabled=false;
            }
            if(data.length==0){
                $scope.no_more_results = true;
                $scope.enabled = false;
                if($routeParams.search!='all')
                    $scope.no_results = true;
            }
        })
    }

    $scope.distance_filter = function(filter){
        angular.element('nav#menu').trigger('close');
        $location.search('filter',filter);
    }

    $scope.unlock = function(poster) {
        if($cookies['mobile_number']=='verified'){
            new PNotify({title: poster.brand_name+' - Offer sent', text: poster.sms_text});
            $scope.change_icon = false;
            poster.is_unlocked = true;
            poster.ad_usage++;
            $http({
                method: 'POST',
                url   : domain+'set_sms_data.json',
                params: {
                    customer_uuid: $cookies.customer_uuid,
                    ad_id: poster.ad_id,
                    outlet_id: poster.outlet_id,
                    brand_name: poster.brand_name,
                    distance: parseFloat(poster.distance).toPrecision(2),
                    longitude: poster.longitude,
                    latitude: poster.latitude,
                    misc_sms: false
                }
            })
        }
        else
            angular.element('#mobile-number').modal('show');
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

    $scope.vvv = function(brand_name, ad_id, outlet_id){
        $http({
            method: 'POST',
            url   : domain+'set_sms_data.json',
            params: {
                customer_uuid: $cookies.customer_uuid,
                whatsapp_share: true,
                outlet_id: outlet_id,
                ad_id: ad_id,
                brand_name: brand_name,
                misc_sms: false
            }
        }).success(function(data){
            if(app_type=='native')
                window.plugins.socialsharing.shareViaWhatsApp(data,null,null,success,function(msg){window.plugins.socialsharing.shareViaSMS(data,null,success,failure)})
            else{}
        });
    }

    $scope.sweepstakes_whatsapp_share = function(brand_name, ad_id, outlet_id){
        $http({
            method: 'POST',
            url   : domain+'sweepstakes_set_sms_data.json',
            params: {
                customer_uuid: $cookies.customer_uuid,
                whatsapp_share: true,
                outlet_id: outlet_id,
                ad_id: ad_id,
                brand_name: brand_name,
                misc_sms: false
            }
        }).success(function(data){
            if(app_type=='native')
                window.plugins.socialsharing.shareViaWhatsApp(data,null,null,success,function(msg){window.plugins.socialsharing.shareViaSMS(data,null,success,failure)})
            else{}
        });
    }

    $scope.show_modal = function(){
        if($cookies['mobile_number']=='not_verified'||$cookies['mobile_number']=='true'){
            angular.element('#verification').modal('show');
        }
        else if($cookies['mobile_number']=='false'){
            angular.element('#mobile-number').modal('show');
        }
    }

    $scope.verified = function(){
        if($cookies.mobile_number=='verified')
            return true;
        else
            return false;
    }


    $scope.poster_share = function(outlet_id, distance, latitude, longitude, brand_name){
        if($cookies['mobile_number']=='verified'){
            new PNotify({ title: ' ', text: 'You will receive a SMS from Shoffr shortly. Kindly share the link with your friends'});
            $http({
                method: 'POST',
                url   : domain+'set_sms_data.json',
                params: {
                    customer_uuid: $cookies.customer_uuid,
                    outlet_id: outlet_id,
                    poster_share: true,
                    distance: parseFloat(distance).toPrecision(2),
                    latitude: latitude,
                    longitude: longitude,
                    brand_name: brand_name,
                    misc_sms: true
                }
            })
        }
        else{
            angular.element('#mobile-number').modal('show');
        }
    }

    $scope.sweepstakes_poster_share = function(outlet_id, distance, latitude, longitude, brand_name){
        if($cookies['mobile_number']=='verified'){
            new PNotify({ title: ' ', text: 'You will receive a SMS from Shoffr shortly. Kindly share the link with your friends'});
            $http({
                method: 'POST',
                url   : domain+'sweepstakes_set_sms_data.json',
                params: {
                    customer_uuid: $cookies.customer_uuid,
                    outlet_id: outlet_id,
                    poster_share: true,
                    distance: parseFloat(distance).toPrecision(2),
                    latitude: latitude,
                    longitude: longitude,
                    brand_name: brand_name,
                    misc_sms: true
                }
            })
        }
        else{
            angular.element('#mobile-number').modal('show');
        }
    }
})

