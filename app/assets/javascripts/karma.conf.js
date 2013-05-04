// Karma configuration
// Generated on Sat May 04 2013 17:44:21 GMT+0100 (BST)


// base path, that will be used to resolve files and exclude
basePath = '';

frameworks = ['sinon-qunit'];

// list of files / patterns to load in the browser
files = [
  QUNIT,
  QUNIT_ADAPTER,
  'vendor/jquery-1.9.1.js',
  'vendor/handlebars.js',
  'vendor/ember-latest.js',
  'vendor/ember-data-latest.js',
  'vendor/moment.js',

  'test/**/*_test.coffee',

  'brain.js',
  'octopus.js',
  'models/**/*.coffee'
];


// list of files to exclude
exclude = [
  
];


// test results reporter to use
// possible values: 'dots', 'progress', 'junit'
reporters = ['progress'];


// web server port
port = 9876;


// cli runner port
runnerPort = 9100;


// enable / disable colors in the output (reporters and logs)
colors = true;


// level of logging
// possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
logLevel = LOG_INFO;


// enable / disable watching file and executing tests whenever any file changes
autoWatch = true;


// Start these browsers, currently available:
// - Chrome
// - ChromeCanary
// - Firefox
// - Opera
// - Safari (only Mac)
// - PhantomJS
// - IE (only Windows)
browsers = ['PhantomJS'];


// If browser does not capture in given timeout [ms], kill it
captureTimeout = 60000;

preprocessors = {
  '**/*.coffee': 'coffee'
};

// Continuous Integration mode
// if true, it capture browsers, run tests and exit
singleRun = false;
