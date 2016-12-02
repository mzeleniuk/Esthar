Esthar.controller('PostsCtrl', ['$scope', 'toastr', 'posts', 'post', 'Auth',
  function ($scope, toastr, posts, post, Auth) {
    $scope.post = post;
    $scope.signedIn = Auth.isAuthenticated;

    $scope.addComment = function () {
      if (!$scope.body || $scope.body === '') {
        return;
      }

      posts.addComment(post.id, {
        body: $scope.body,
        author: 'user'
      }).success(function (comment) {
        $scope.post.comments.push(comment);
      });

      $scope.body = '';

      $scope.form.$setPristine();
      $scope.form.$setUntouched();
    };

    $scope.incrementUpvotes = function (comment) {
      posts.upvoteComment(post, comment).error(function () {
        toastr.warning("It seems you've already voted for this comment.", 'Oops...');
      });
    };
  }
]);
