var Esthar = angular.module('Esthar', ['ui.router', 'templates']);

Esthar.config([
  '$stateProvider',
  '$urlRouterProvider',

  function ($stateProvider, $urlRouterProvider) {
    $stateProvider
      .state('home', {
        url: '/home',
        templateUrl: 'home/_home.html',
        controller: 'MainCtrl'
      })

      .state('posts', {
        url: '/posts/{id}',
        templateUrl: 'posts/_posts.html',
        controller: 'PostsCtrl'
      });

    $urlRouterProvider.otherwise('home');
  }
]);
