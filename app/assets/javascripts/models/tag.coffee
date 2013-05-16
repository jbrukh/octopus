App.Tag = Em.Object.extend
  updateFromTo: (->
    extent = @get('extent')
    return if extent == null
    @set 'from', Math.floor(extent[0])
    @set 'to', Math.floor(extent[1])
  ).observes('extent')