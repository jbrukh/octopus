module.exports = function(config) {
  config.set({

    basePath: '',

    frameworks: ["jasmine"],

    // list of files / patterns to load in the browser
    files: [
      'vendor/jquery-1.10.2.js',
      'vendor/handlebars-1.0.0.js',
      'vendor/ember-1.0.0-rc.7.js',
      'vendor/ember-model-latest.js',
      'vendor/moment.js',

      'octopus.js',
      'lib/**/*',
      'models/**/*',
      'controllers/**/*',

      'test/**/*_specs.coffee'
    ],

    // list of files to exclude
    exclude: [ ],

    // test results reporter to use
    // possible values: 'dots', 'progress', 'junit'
    reporters: ['progress'],

    // web server port
    port:  9876,

    // cli runner port
    runnerPort:  9100,

    // enable / disable colors in the output (reporters and logs)
    colors:  true,

    // level of logging
    // possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
    logLevel:  LOG_INFO,

    // enable / disable watching file and executing tests whenever any file changes
    autoWatch:  true,

    // Start these browsers, currently available:
    // - Chrome
    // - ChromeCanary
    // - Firefox
    // - Opera
    // - Safari (only Mac)
    // - PhantomJS
    // - IE (only Windows)
    browsers:  [
      'PhantomJS'
      //, 'Chrome'
    ],

    // If browser does not capture in given timeout [ms], kill it
    captureTimeout:  60000,

    // Continuous Integration mode
    // if true, it capture browsers, run tests and exit
    singleRun:  false,

  });
};