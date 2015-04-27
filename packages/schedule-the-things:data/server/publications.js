/* global Publications:true */
Publications = {};

var publications = {
  appointments: function (arg) {
    console.log("Subscribe to appts: " + arg);
    return Collections.Appointments.find();
  }
};

_.each(publications, function(pubFn, pubName) {
  Publications[pubName] = undefined;
  Meteor.publish(pubName, pubFn);
});
