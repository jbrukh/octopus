ruby "2.0.0"
source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0.rc2'

# db
gem 'pg'

# tasks
gem 'sidekiq'
gem "slim", "~> 2.0.0.pre.8"
gem 'sinatra', '>= 1.3.0', :require => nil

# use the vendor ember for now, reinstate this
# when ember is released
#gem 'ember-source', '1.0.0.rc3'

# ember data isn't up to date
# once it is, re-add this and remove the vendor reference
# gem 'ember-data-source'
gem 'handlebars-source', '1.0.0.rc4'
gem "ember-rails", github: 'emberjs/ember-rails'

# authentication/authorization
gem 'devise', github: 'plataformatec/devise', branch: 'rails4'
gem 'cancan'

# models
gem 'state_machine'
gem 'paperclip'
gem 'bindata'
gem 'strip_attributes'

# real time
gem 'redis'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 4.0.0.rc1'
  gem 'coffee-rails', '~> 4.0.0.rc1'

  gem "font-awesome-rails"

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', platforms: :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.0.1'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# web server
gem 'rainbows'
gem 'em-http-request'

# heroku plogins
gem 'newrelic_rpm'

group :development do
  gem 'quiet_assets'
end

group :test, :development do
  gem "shoulda-matchers"
  gem "rspec-rails", "~> 2.0"
  gem 'mocha', :require => false

  gem 'factory_girl_rails'

  gem 'rb-inotify', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-fchange', :require => false
  gem 'guard'
  gem 'guard-rspec'

  gem 'jazz_hands'
  gem 'better_errors'
  gem "binding_of_caller"
end