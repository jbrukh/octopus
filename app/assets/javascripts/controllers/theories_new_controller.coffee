App.TheoriesNewController = Em.ObjectController.extend

  availableMedia: (->
    mediaType = @get 'selectedMediaType'
    switch mediaType
      when 'video' then App.Video.find()
      else Em.A []
  ).property('selectedMediaType')