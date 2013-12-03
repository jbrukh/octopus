# attr = Ember.attr

# App.Tagging = Ember.Model.extend

#   id:           attr()
#   name:         attr()
#   fromMs:       attr(Number)
#   toMs:         attr(Number)

#   updateFromTo: (->
#     extent = @get('extent')
#     return if extent == null
#     @set 'fromMs', Math.floor(extent[0])
#     @set 'toMs', Math.floor(extent[1])
#   ).observes('extent')

# App.Tagging.rootKey = 'tagging'
# App.Tagging.collectionKey = 'taggings'
# App.Tagging.camelizeKeys = true
# App.Tagging.adapter = App.TaggingAdapter.create()