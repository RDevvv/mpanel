app.factory('appScroll',function($http){
    var fetch_posters = function(){
        this.busy = false;
        this.no_more_results = false;

        if(this.no_more_results == false){
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
                for(i=0;i<data.length;i++){
                    $scope.posters.push(data[i]);
                }
            })
        }
    }
})
