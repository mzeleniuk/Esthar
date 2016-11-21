Esthar.controller('MainCtrl', ['$scope', '$timeout', 'posts', 'Auth',
  function ($scope, $timeout, posts, Auth) {
    $scope.posts = posts.posts;
    $scope.signedIn = Auth.isAuthenticated;

    $scope.addPost = function () {
      if (!$scope.title || $scope.title === '' || !$scope.body || $scope.body === '') {
        return;
      }

      posts.create({
        title: $scope.title,
        link: $scope.link,
        body: $scope.body
      });

      $scope.title = '';
      $scope.link = '';
      $scope.body = '';

      $scope.form.$setPristine();
      $scope.form.$setUntouched();
    };

    $scope.incrementUpvotes = function (post) {
      posts.upvote(post).error(function () {
        $scope.postAlreadyVoted = true;

        $timeout(function () {
          $scope.postAlreadyVoted = false
        }, 3000);
      });
    };
  }
]);
