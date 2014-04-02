app.controller('HomeController', ['$scope', '$http', '$routeParams', '$cookies', '$location', function($scope, $http, $routeParams, $cookies, $location){
    $scope.home_submit = function(location, latitude, longitude){
        console.log(location);
        $location.url('/outlet_view?search=all&location='+location+'&latitude='+latitude+'&longitude='+longitude+'&view=outlet_listing')
    }

}])
