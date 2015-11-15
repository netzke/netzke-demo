source 'http://rubygems.org'

gem 'rails', '~>4.2.0'
gem 'activerecord-session_store'

gem 'faker'
gem 'pg'
gem 'carrierwave'

# gem 'netzke', '~>1.0.0.alpha', github: 'netzke/netzke', branch: 'master'
gem 'netzke-core', github: "netzke/netzke-core", branch: 'master'
gem 'netzke-basepack', github: "netzke/netzke-basepack", branch: 'master'
gem 'netzke-testing', github: "netzke/netzke-testing", branch: 'master'

gem 'awesome_nested_set'
gem 'whenever', :require => false

group :development, :test do
  gem 'pry'
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'selenium-webdriver'
  gem 'rspec-rails'
  gem 'spork-rails'
  gem 'launchy'    # So you can do Then show me the page
  gem 'factory_girl_rails'
end

group :development do
  gem 'capistrano', '~> 3.0.1'
  gem 'capistrano-bundler'
  gem 'capistrano-rails', '~> 1.1.0'
  gem 'capistrano-rails-console'
  gem 'capistrano-passenger'
end
