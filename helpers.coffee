Feedings.helpers
  when: (fmt="calendar")->
    if fmt is "calendar"
      moment(@time).calendar()
    else
      moment(@time).format(fmt)
  detail: ->
    if @bottleAmount
      "#{@bottleAmount} oz"
    else
      (if @L then "L" else "") + (if @R then "R" else "")
  minuteDuration: ->
    if @endTime
      [start, end] = [moment(@time), moment(@endTime)]
      Math.ceil moment.duration(end.diff(start)).asMinutes()
  displayEndTime: ->
    if @minuteDuration() >= 20
      @endTime
    else
      moment(@time).add(minutes: 20).toDate()
  duration: ->
    unless @endTime
      "(in progress)"
    else
      "#{@minuteDuration()} minutes"
