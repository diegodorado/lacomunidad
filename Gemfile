source 'http://rubygems.org'

gem 'rails', '3.1.1'

gem "jquery-rails",'1.0.19'
#for action.js.coffe views to work on production
gem 'coffee-rails','3.1.1'

gem "haml",'3.1.4'
gem "redcarpet",'2.1.0'

gem "rails-settings-cached"
gem "cancan"

#for opengraph
gem 'rest-client','1.6.7'
gem 'nokogiri','1.5.0'

gem 'formtastic', '~> 2.1.0.beta1'
gem 'formtastic-bootstrap', git: 'git://github.com/cgunther/formtastic-bootstrap.git', branch: 'bootstrap2-rails3-2-formtastic-2-1'

gem "devise", '2.0.0'
gem "omniauth", '1.0.2'
gem 'omniauth-facebook','1.2.0'
gem 'omniauth-google-oauth2', '0.1.9'
gem "paperclip", '2.5.2'
gem 'aws-s3', '0.6.2'
gem 'aws-sdk', '1.3.3'
gem "friendly_id", "~> 4.0.0.beta8"
gem 'acts_as_commentable', '3.0.1'
gem 'thumbs_up','0.4.6'


group :assets do
  gem 'haml_assets','0.0.5'
  gem 'sass-rails', '3.1.4'
  gem 'uglifier','1.2.3'
  gem "js-routes", '0.7.4'
  gem 'less-rails-bootstrap', '2.0.4'
  gem "rails-backbone", '0.6.1' #0.5.4
end


group :production do
  gem 'pg'
end

group :development do
#  gem 'guard-livereload'
#  gem 'rack-livereload'
  gem 'rspec-rails'
  gem "annotate"
  gem 'sqlite3'
  gem "nifty-generators"
  gem "faker"
  gem "populator"
end

group :test do
  gem "mocha"
  gem 'rspec'
  gem 'webrat'
end
