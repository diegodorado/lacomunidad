Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '69zFv7uQAFFj3012FWYQ', 'aIq4aH8V7YcXIO4f7I2CIbQmXrwXna3MVKmjUDxb8'
  provider :facebook, 'APP_ID', 'APP_SECRET'
  provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end
