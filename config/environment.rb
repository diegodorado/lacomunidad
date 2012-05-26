# Load the rails application
require File.expand_path('../application', __FILE__)

Lacomunidad::Application.configure do
  config.time_zone = 'Buenos Aires'  
end

# Initialize the rails application
Lacomunidad::Application.initialize!
