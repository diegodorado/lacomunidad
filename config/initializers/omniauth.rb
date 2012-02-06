Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '414160349277', '21397cb9d28b334e874d1a412f6a417e', {:scope => 'publish_stream,email'}
  provider :google_oauth2, '461429600233.apps.googleusercontent.com', 'CNWsWpNhczFERP8tm7xWrOx6', {access_type: 'online', approval_prompt: ''}
end

module OmniAuth
  def self.allowed_providers
    [:facebook, :google_oauth2]
  end  
end
