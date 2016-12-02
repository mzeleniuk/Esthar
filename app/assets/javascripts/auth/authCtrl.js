Esthar.controller('AuthCtrl', ['$scope', '$state', 'Auth', 'toastr',
  function ($scope, $state, Auth, toastr) {
    $scope.login = function () {
      Auth.login($scope.user).then(function () {
        $state.go('home');
      },
      function () {
        toastr.error(
          'Maybe you entered incorrect email or password. Please try again.',
          'Something went wrong!'
        );
      });
    };

    $scope.register = function () {
      Auth.register($scope.user).then(function () {
        $state.go('home');
      });
    };
  }
]);
