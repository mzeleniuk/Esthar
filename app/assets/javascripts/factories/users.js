Esthar.factory('users', ['$http', function ($http) {
  var object = {
    users: []
  };

  object.get = function (id) {
    return $http.get('/users/' + id + '.json').then(function (response) {
      return response.data;
    });
  };

  object.update = function (user) {
    return $http.patch('/users/' + user.id + '.json', user);
  };

  return object;
}]);
