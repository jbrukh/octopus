App.RecordableShow = Ember.Mixin.create
  exportAsCsv: ->
    console.log 'Exporting as CSV'
    recordingData = @get 'recordingData'
    blob = new Blob [recordingData.exportAsCsv()], {type: 'text/csv'}
    id = @get 'model.id'
    saveAs(blob, "octopus_#{id}.csv");
