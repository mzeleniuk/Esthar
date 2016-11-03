Esthar.factory('posts', ['$http', function ($http) {
  var object = {
    posts: []
  };

  object.getAll = function () {
    return $http.get('/posts.json').success(function (data) {
      angular.copy(data, object.posts);
    });
  };

  return object;
}]);
