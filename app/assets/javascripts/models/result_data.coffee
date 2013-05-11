App.ResultData = Em.Object.extend
  storageMode: (->
    switch @get('rawStorageMode')
      when 1 then 'parallel'
      when 2 then 'sequential'
      else throw 'unknown storage mode'
  ).property('rawStorageMode')