var Esthar = angular.module('Esthar', [
  'ui.router',
  'templates',
  'Devise',
  'ngAnimate',
  'angular-medium-editor',
  'ngSanitize',
  'truncate',
  'toastr',
  'xeditable',
  'ui.mask'
]);

Esthar.config([
  '$stateProvider',
  '$urlRouterProvider',
  'toastrConfig',

  function ($stateProvider, $urlRouterProvider, toastrConfig) {
    $stateProvider
      .state('home', {
        url: '/home',
        templateUrl: 'home/_home.html',
        controller: 'MainCtrl',
        resolve: {
          postPromise: ['posts', function (posts) {
            return posts.getAll();
          }]
        }
      })

      .state('posts', {
        url: '/posts/{id}',
        templateUrl: 'posts/_posts.html',
        controller: 'PostsCtrl',
        resolve: {
          post: ['$stateParams', 'posts', function ($stateParams, posts) {
            return posts.get($stateParams.id);
          }]
        }
      })

      .state('users', {
        url: '/users/{id}',
        templateUrl: 'users/_user.html',
        controller: 'UsersCtrl',
        resolve: {
          user: ['$stateParams', 'users', function ($stateParams, users) {
            return users.get($stateParams.id);
          }]
        }
      })

      .state('login', {
        url: '/login',
        templateUrl: 'auth/_login.html',
        controller: 'AuthCtrl',
        onEnter: ['$state', 'Auth', function ($state, Auth) {
          Auth.currentUser().then(function () {
            $state.go('home');
          });
        }]
      })

      .state('register', {
        url: '/register',
        templateUrl: 'auth/_register.html',
        controller: 'AuthCtrl',
        onEnter: ['$state', 'Auth', function ($state, Auth) {
          Auth.currentUser().then(function () {
            $state.go('home');
          });
        }]
      });

    $urlRouterProvider.otherwise('home');

    angular.extend(toastrConfig, {
      positionClass: 'toast-top-right',
      allowHtml: false,
      closeButton: true,
      progressBar: true
    });
  }
]);

Esthar.run(['editableOptions',
  function (editableOptions) {
    editableOptions.theme = 'bs3';
  }
]);
