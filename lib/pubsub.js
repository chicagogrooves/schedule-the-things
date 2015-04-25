Appointments = new Mongo.Collection("appointments");

Meteor.atServer( function () {
  Meteor.publish("appointments", function () {
    return Appointments.find();
  });
});
