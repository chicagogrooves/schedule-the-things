newFeeding = (fields) ->
  family = Meteor.user().profile?.familyMembers || []
  family.push Meteor.userId()
  fields.users = family
  fields.time = new Date
  Feedings.insert fields

timer = undefined

Template.feeding.created = ->
  timer = new ReactiveTimer(1)

Template.feeding.destroyed = ->
  timer.stop()
  timer = undefined

Template.feeding.helpers
  active: (which) ->
    if @[which] then "active" else ""
  currentFeeding: ->
    JSON.stringify(@)
  elapsed: ->
    if @time
      timer.tick() # makes it reactive
      moment(new Date - @time).format "mm:ss"
  showBottleParams: ->
    if @bottleAmount then "" else "hide"

Template.feeding.events
  "click .btnHistory": ->
    Router.go "history"

  "click #btn-end": (e) ->
    Feedings.update @._id, $set: {endTime: new Date, completed: true}
    Router.go "history"

  "click .which": (e) ->
    fields = {}
    which = $(e.target).data("which")
    fields[which] = true
    id = newFeeding fields
    $(".btn-bottle, .which").prop("disabled", true)
    $(e.target).prop("disabled", false)
    timer.start()
    e.target.blur()

  "click .btn-bottle": (e) ->
    $(".btn-bottle, .which").prop("disabled", true)
    $(e.target).prop("disabled", false)
    $(".bottle-params").show()
    id = newFeeding bottleAmount: 2.0

  "click .bottle-ctl": (e) ->
    amt = $(e.target).data("amount")
    Feedings.update @._id, $inc: {bottleAmount: Number(amt)}
