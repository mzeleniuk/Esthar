var Esthar = angular.module('Esthar', ['ui.router']);

Esthar.config([
  '$stateProvider',
  '$urlRouterProvider',

  function($stateProvider, $urlRouterProvider) {
    $stateProvider
      .state('home', {
        url: '/home',
        templateUrl: '/home.html',
        controller: 'MainCtrl'
      });

    $urlRouterProvider.otherwise('home');
  }
]);

Esthar.factory('posts', [function() {
  var object = {
    posts: [
      {title: 'Post 1', upvotes: 5},
      {title: 'Post 2', upvotes: 2},
      {title: 'Post 3', upvotes: 15},
      {title: 'Post 4', upvotes: 9},
      {title: 'Post 5', upvotes: 4}
    ]
  };

  return object;
}]);

Esthar.controller('MainCtrl', [
  '$scope',
  'posts',

  function($scope, posts) {
    $scope.posts = posts.posts;

    $scope.addPost = function() {
      if(!$scope.title || $scope.title === '') { return; }

      $scope.posts.push({
        title: $scope.title,
        link: $scope.link,
        upvotes: 0
      });

      $scope.title = '';
      $scope.link = '';

      $scope.form.$setPristine();
      $scope.form.$setUntouched();
    };

    $scope.incrementUpvotes = function(post) {
      post.upvotes += 1;
    };
  }
]);
