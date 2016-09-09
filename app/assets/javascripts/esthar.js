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
      })

      .state('posts', {
        url: '/posts/{id}',
        templateUrl: '/posts.html',
        controller: 'PostsCtrl'
      });

    $urlRouterProvider.otherwise('home');
  }
]);

Esthar.factory('posts', [function() {
  var object = {
    posts: [
      {title: 'Post 1', upvotes: 5, comments: [{author: 'Angy', body: 'Great!', upvotes: 0}]},
      {title: 'Post 2', upvotes: 2, comments: [{author: 'Jane', body: 'Hi!', upvotes: 0}]},
      {title: 'Post 3', upvotes: 15, comments: [{author: 'Joe', body: 'Cool post!', upvotes: 0}]},
      {title: 'Post 4', upvotes: 9, comments: [{author: 'Michael', body: 'This is test.', upvotes: 0}]},
      {title: 'Post 5', upvotes: 4, comments: [{author: 'Hinata', body: ':)', upvotes: 0}]}
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
        upvotes: 0,
        comments: [
          {author: 'Joe', body: 'Cool post!', upvotes: 0},
          {author: 'Bob', body: 'Great idea but everything is wrong!', upvotes: 0}
        ]
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

Esthar.controller('PostsCtrl', [
  '$scope',
  '$stateParams',
  'posts',

  function($scope, $stateParams, posts) {
    $scope.post = posts.posts[$stateParams.id];

    $scope.addComment = function() {
      if (!$scope.body || $scope.body === '') { return; }

      $scope.post.comments.push({
        body: $scope.body,
        author: 'user',
        upvotes: 0
      });

      $scope.body = '';

      $scope.form.$setPristine();
      $scope.form.$setUntouched();
    };

    $scope.incrementUpvotes = function(comment) {
      comment.upvotes += 1;
    };
  }
]);
