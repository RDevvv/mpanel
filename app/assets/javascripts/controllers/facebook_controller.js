app.controller('FacebookController', function($scope, $routeParams, Restangular){
  var facebook_posts = Restangular.one('accounts',account_id).one('brands',$routeParams.brand_id).all('facebook_posts');
  facebook_posts.getList().then(function(facebook_posts){
    $scope.posts = facebook_posts;
  });
})
