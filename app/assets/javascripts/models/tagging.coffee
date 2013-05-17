App.Tagging = DS.Model.extend

  name:         DS.attr 'string'
  fromMs:       DS.attr 'number'
  toMs:         DS.attr 'number'

  updateFromTo: (->
    extent = @get('extent')
    return if extent == null
    @set 'fromMs', Math.floor(extent[0])
    @set 'toMs', Math.floor(extent[1])
  ).observes('extent')