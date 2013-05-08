App.ExperimentsNewController = Em.ObjectController.extend

  availableMedia: (->
    mediaType = @get 'selectedMediaType'
    switch mediaType
      when 'video' then App.Video.find()
      else Em.A []
  ).property('selectedMediaType')

  updateSelectedMedia: (->
    selected = @get('selectedMedia')
    return unless selected > 0
    @set 'model.media', App.Media.createRecord({id: selected})
  ).observes('selectedMedia')