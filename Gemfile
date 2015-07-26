source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem "jquery-ui-rails" 
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development


# Slim
gem 'slim'
gem 'slim-rails'

# JS Helper library
gem 'underscore-rails'

#For bootstrap
gem 'bootstrap-sass', '~> 3.2.0'

# For orginize tree structure
gem 'awesome_nested_set'
gem "the_sortable_tree", "~> 2.5.0"

# For admin area
gem 'activeadmin', '~> 1.0.0.pre1'
gem 'devise'



# For tagging
gem 'acts-as-taggable-on', '~> 3.4'
gem "selectize-rails"

#For searching on server_side
gem 'elasticsearch-model'
gem 'elasticsearch-rails'
#For searching on client side
gem 'jquery-datatables-rails', github: 'rweng/jquery-datatables-rails'

#For delayed job
gem 'delayed_job_active_record'
gem 'daemons'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  #gem 'spring'

  gem 'rspec-rails'
  gem 'factory_girl_rails'
  # gem 'database_cleaner' #чистит тестувую базу
  # gem 'capybara'

  #Generate humanize random data
  gem 'forgery' 

  
  gem 'spork', git: 'git://github.com/manafire/spork.git', ref: '38c79dcedb246daacbadb9f18d09f50cc837de51'
  gem 'spork-rails', '~> 4.0.0'

  gem 'guard-rails'
  gem 'guard-rspec', '~> 4.5.0', require: false
  gem 'guard-livereload'
  gem 'guard-bundler'
  gem 'guard-spork'

end

