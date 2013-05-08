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

 * `bundle install`
 * `rails s`

To run the specs:

 * `guard`

To deploy to heroku:

 * `heroku pg:reset` (if a database RESET is required)
 * git push heroku
