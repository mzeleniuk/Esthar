Esthar.factory('posts', [function () {
  var object = {
    posts: [
      {title: 'Post 1', upvotes: 5, comments: [{author: 'Angy', body: 'Great!', upvotes: 0}]},
      {title: 'Post 2', upvotes: 2, comments: [{author: 'Jane', body: 'Hi!', upvotes: 0}]},
      {title: 'Post 3', upvotes: 15, comments: [{author: 'Joe', body: 'Cool post!', upvotes: 0}]},
      {title: 'Post 4', upvotes: 9, comments: [{author: 'Michael', body: 'This is test.', upvotes: 0}]},
      {title: 'Post 5', upvotes: 4, comments: [{author: 'Drake', body: ':)', upvotes: 0}]}
    ]
  };

  return object;
}]);
