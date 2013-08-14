// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require handlebars
//= require vendor/d3.v3
//= require vendor/ember-control
//= require vendor/ember-latest
//= require vendor/ember-model-latest
//= require vendor/moment
//= require vendor/livestamp
//= require vendor/bootstrap
//= require vendor/showdown
//= require vendor/bootstrap-datepicker
//= require vendor/filesaver
//= require bootstrapped
//= require_self
//= require brain

Ember.ENV.HELPER_PARAM_LOOKUPS = true;

App = Ember.Application.create({
  LOG_TRANSITIONS: true,
  LOG_VIEW_LOOKUPS: true,
  LOG_ACTIVE_GENERATION: true
});

//= require_tree .