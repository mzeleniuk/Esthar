Esthar.factory('users', ['$http', function ($http) {
  var object = {
    users: []
  };

  object.get = function (id) {
    return $http.get('/users/' + id + '.json').then(function (response) {
      return response.data;
    });
  };

  return object;
}]);
