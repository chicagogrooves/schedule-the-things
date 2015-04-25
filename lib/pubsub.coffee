@Appointments = new Mongo.Collection("appointments")
@DaysAtATime = 2
@tzAdjust = 19

@currentFeeding = ->
  Appointments.find {completed: {$ne: true}},
    limit: 1
    sort: [["time", "desc"]]

Meteor.atServer ->
  Meteor.publish "appointments", (daysBack = DaysAtATime) ->
    howfar = moment(new Date)
      .startOf("day")
      .subtract
        days: daysBack-1
        hours: tzAdjust # needed for prod only, cuz - timezones?
      .toDate()

    Appointments.find
      # time:
      #   $gt: howfar
      users:
        $in:
          [@userId]
    , sort: [["time", "desc"]], limit: 128 # hack for speed :/

Meteor.atClient ->
  Meteor.subscribe "appointments"
