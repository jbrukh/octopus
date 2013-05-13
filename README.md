README
======

This project is the web application and front end API for Octopus. It consists of a vanilla Rails application and an
Ember application located in `/app/assets/javascripts/octopus`.

Getting Started
===============

You will need to install the following:

 * [Homebrew](http://mxcl.github.io/homebrew/)
 * [RVM](https://rvm.io/)
 * Ruby 2.0.0

To run the site locally:

 * `gem install foreman`
 * `bundle install`
 * `rake db:setup`
 * `foreman start`

To run the specs:

 * `guard` (rails specs)
 * `karma start` (js specs, run from js-app)

To deploy to heroku:

 * `heroku pg:reset` (if a database RESET is required)
 * git push heroku

To see background worker status:

 * http://localhost:port/sidekiq