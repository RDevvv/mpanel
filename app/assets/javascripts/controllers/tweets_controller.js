app.controller('TweetsController', function($scope, $routeParams, Restangular){
  var twitter_posts = Restangular.one('accounts',account_id).one('brands',$routeParams.brand_id).all('tweets');
  twitter_posts.getList().then(function(tweets){
    $scope.tweets = tweets;
  });
})

