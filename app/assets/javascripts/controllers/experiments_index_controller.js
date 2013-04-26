App.ExperimentsIndexController = Ember.Controller.extend(Ember.Evented, {
  init: function(){
    var dataAdapters = ['mock', 'live'];
    this.set('selectedDataAdapter', 'mock');
    this.set('dataAdapters', dataAdapters);
  },

  start: function(){
    console.log('starting experiment');
    this.set('isRunning', true);

    var dataAdapter = this.get('dataAdapter');

    dataAdapter.start();

    this.trigger('didStart');
  },

  stop: function(){
    console.log('stopping experiment');
    this.set('isRunning', false);

    var dataAdapter = this.get('dataAdapter');
    dataAdapter.stop();
    this.trigger('didStop');
  },

  changeDataAdapter: function(){
    var adapter = this.get('selectedDataAdapter');
    if(adapter === 'mock'){
      var mockAdapter = App.MockDataAdapter.create({
        resolution: 20,
        channels: 8
      });
      this.set('dataAdapter', mockAdapter);
      return;
    }

    if(adapter === 'live'){
      var wsAdapter = App.WebSocketDataAdapter.create({
        url: 'ws://localhost:8000/device'
      });
      this.set('dataAdapter', wsAdapter);
      return;
    }
  }.observes('selectedDataAdapter')
});