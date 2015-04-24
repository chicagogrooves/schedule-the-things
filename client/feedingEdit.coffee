Template.feedingEdit.helpers
  startAdjusterOptions: ->
    optionFor = (t) ->
      text: t.format("h:mm a")
      value: "#{h}|#{m}"

    opts = [(optionFor moment @time)]
    for h in [0..23]
      for m in [0, 15, 30, 45]
        t = moment hours: h, minutes: m
        opts.push optionFor t
    opts

  when: (fmt="calendar") ->
    if fmt is "calendar"
      moment(@time).calendar()
    else
      moment(@time).format(fmt)

  ended: (fmt="calendar")->
    moment(@endTime).format(fmt)

  showBottleParams: ->
    if @bottleAmount then "" else "hide"

timeSetter = (timeField) ->
  (e) ->
    amt = $(e.target).data("amount")
    newTime = moment(@[timeField]).add({minutes: amt})
    setter = {}
    setter[timeField] = newTime.toDate()
    Feedings.update @_id, $set: setter

Template.feedingEdit.events
  "click .start-ctl": timeSetter("time")
  "click .end-ctl": timeSetter("endTime")

  "click .btnHistory": ->
    Router.go "history"

  "click .deleteButton": (e) ->
    if confirm("Delete this feeding?")
      Feedings.remove(@._id)
      Router.go "history"

  "click .bottle-ctl": (e) ->
    amt = $(e.target).data("amount")
    Feedings.update @._id, $inc: {bottleAmount: Number(amt)}

  "change .newStart": (e) ->
    [h, m] = $(e.target).val().split("|")
    newTime = moment(@time).startOf("day").add
      hours: h
      minutes: m
    Feedings.update @_id, $set: {time: newTime.toDate()}
