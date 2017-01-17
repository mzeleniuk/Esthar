Esthar.controller('UsersCtrl', ['$scope', 'toastr', 'users', 'user', 'Auth',
  function ($scope, toastr, users, user, Auth) {
    $scope.user = user;
    $scope.signedIn = Auth.isAuthenticated;
    Auth.currentUser().then(function (current_user) {
      $scope.currentUser = current_user;
    });

    $scope.updateUser = function () {
      users.update(user).success(function () {
        toastr.success('Your profile was successfully updated.', 'Success!');
      }).error(function () {
        toastr.error('Something very bad occurred. Please try again.', 'Oops...');
      });
    };
  }
]);
