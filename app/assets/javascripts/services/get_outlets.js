app.factory('getOutlet',['$routeParams', '$http', function($routeParams, $http){
    return{
        fetch_outlets: function(succeedcb){
            if($routeParams['location']!='undefined'){
            $http({
                method: 'GET',
                url: 'outlet_listing.json',
                params :{location: $routeParams['location'], view: $routeParams['view'], search: $routeParams['search'], filter: $routeParams['filter'] }
            })
            .then(function(response){ succeedcb(response.data)});
            }
        }
    };
}])
