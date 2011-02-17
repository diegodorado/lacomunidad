require 'openid/store/filesystem' 
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '69zFv7uQAFFj3012FWYQ', 'aIq4aH8V7YcXIO4f7I2CIbQmXrwXna3MVKmjUDxb8'
  provider :facebook, '414160349277', '21397cb9d28b334e874d1a412f6a417e', {:scope => 'publish_stream,email'}
  provider :open_id, OpenID::Store::Filesystem.new('./tmp'), {:name => "google", :domain => "https://www.google.com/accounts/o8/id" }
  provider :open_id, OpenID::Store::Filesystem.new('./tmp'), {:name => "yahoo", :domain => "https://me.yahoo.com"}

end
