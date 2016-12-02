// Angular Truncate - Ellipsis for your templates
// http://sparkalow.github.com/angular-truncate
// Brian Mathews (sparkalow)

// Moved library here because of outdated Angular dependency in "bower.json"
// Angular 1.5.8 (and later) are not supported from the Bower's default package

angular.module('truncate', [])
  .filter('characters', function () {
    return function (input, chars, breakOnWord) {
      if (isNaN(chars)) return input;
      if (chars <= 0) return '';

      if (input && input.length > chars) {
          input = input.substring(0, chars);

        if (!breakOnWord) {
          var lastspace = input.lastIndexOf(' ');

          //get last space
          if (lastspace !== -1) {
            input = input.substr(0, lastspace);
          }
        } else {
          while (input.charAt(input.length - 1) === ' ') {
            input = input.substr(0, input.length - 1);
          }
        }

        return input + '…';
      }

      return input;
    };
  })

  .filter('splitcharacters', function () {
    return function (input, chars) {
      if (isNaN(chars)) return input;
      if (chars <= 0) return '';

      if (input && input.length > chars) {
        var prefix = input.substring(0, chars / 2);
        var postfix = input.substring(input.length - chars / 2, input.length);

        return prefix + '...' + postfix;
      }

      return input;
    };
  })

  .filter('words', function () {
    return function (input, words) {
      if (isNaN(words)) return input;
      if (words <= 0) return '';

      if (input) {
        var inputWords = input.split(/\s+/);

        if (inputWords.length > words) {
            input = inputWords.slice(0, words).join(' ') + '…';
        }
      }

      return input;
    };
  });
