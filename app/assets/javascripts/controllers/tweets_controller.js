app.controller('TweetsController', function($scope, $routeParams, Restangular){
  var facebook_posts = Restangular.one('brands',$routeParams.brand_id).all('tweets');
  facebook_posts.getList().then(function(tweets){
    $scope.tweets = tweets;
  });
})

