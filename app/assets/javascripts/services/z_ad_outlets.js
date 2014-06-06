app.factory('AdOutlets', function($routeParams, $http){
    return{
        outlet_ids:[],
        url_location: '',
        posters: []
    };
})
