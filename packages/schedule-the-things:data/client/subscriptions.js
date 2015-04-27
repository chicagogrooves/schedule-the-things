/* global Subscriptions: true */
Subscriptions = {};

// [subNames]
var subscriptions = ["appointments"];

/* Defines an object with methods suitable for
 * living at Subscriptions.subName
*/
function wrapSub (subName) {
  var subscription, subscriptionArgs;

  var wrapper = {
    subscribe: function (/* args */) {
      subscriptionArgs = Array.prototype.slice.apply(arguments);
      subscription = Meteor.subscribe.apply(Meteor, [subName].concat(subscriptionArgs));
    },
    params: function () {
      return subscriptionArgs;
    },
    stop: function () {
      return subscription.stop();
    },
    ready: function () {
      return subscription.ready();
    }
  };

  return wrapper;
}

_.each(subscriptions, function(subName) {
  Subscriptions[subName] = wrapSub(subName);
});
