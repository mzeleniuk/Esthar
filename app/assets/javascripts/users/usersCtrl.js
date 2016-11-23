Esthar.controller('UsersCtrl', ['$scope', 'user', 'Auth',
  function ($scope, user, Auth) {
    $scope.user = user;
    $scope.signedIn = Auth.isAuthenticated;
  }
]);
