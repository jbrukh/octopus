App.ExperimentsIndexController = Ember.Controller.extend({
  start: function(){
    console.log('starting experiment');
    this.set('isRunning', true);

    var dataAdapter = App.MockDataAdapter.create({
      resolution: 50,
      channels: 8
    });

    this.set('dataAdapter', dataAdapter);

    dataAdapter.start();
  },
  stop: function(){
    console.log('stopping experiment');
    this.set('isRunning', false);

    var dataAdapter = this.get('dataAdapter');
    dataAdapter.stop();
  }
});