Esthar.controller('MainCtrl', ['$scope', 'posts', 'Auth',
  function ($scope, posts, Auth) {
    $scope.posts = posts.posts;
    $scope.signedIn = Auth.isAuthenticated;

    $scope.addPost = function () {
      if (!$scope.title || $scope.title === '') {
        return;
      }

      posts.create({
        title: $scope.title,
        link: $scope.link
      });

      $scope.title = '';
      $scope.link = '';

      $scope.form.$setPristine();
      $scope.form.$setUntouched();
    };

    $scope.incrementUpvotes = function (post) {
      posts.upvote(post);
    };
  }
]);
