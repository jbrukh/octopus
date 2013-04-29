ruby "2.0.0"
source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0.beta1'

gem 'pg'

# use the vendor ember for now, reinstate this
# when ember is released
#gem 'ember-source', '1.0.0.rc3'

# ember data isn't up to date
# once it is, re-add this and remove the vendor reference
# gem 'ember-data-source'
gem 'handlebars-source', '1.0.0.rc3'
gem "ember-rails"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 4.0.0.beta1'
  gem 'coffee-rails', '~> 4.0.0.beta1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', platforms: :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.0.1'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
gem 'unicorn'

group :development do
  gem 'quiet_assets'
end

group :test, :development do
  gem "rspec-rails", "~> 2.0"
end