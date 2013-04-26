App.ExperimentsIndexController = Ember.Controller.extend(Ember.Evented, {
  start: function(){
    console.log('starting experiment');
    this.set('isRunning', true);

    var dataAdapter = App.MockDataAdapter.create({
      resolution: 20,
      channels: 8
    });

    //var dataAdapter = App.WebSocketDataAdapter.create({
    //  url: 'ws://localhost:8000/device'
    //});

    this.set('dataAdapter', dataAdapter);

    dataAdapter.start();

    this.trigger('didStart');
  },
  stop: function(){
    console.log('stopping experiment');
    this.set('isRunning', false);

    var dataAdapter = this.get('dataAdapter');
    dataAdapter.stop();
    this.trigger('didStop');
  }
});