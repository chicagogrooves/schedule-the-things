Meteor.startup ->
  Houston.add_collection Meteor.users
  ServiceConfiguration.configurations.update
    service: "google"
  ,
    $set:
      loginStyle: "redirect"
