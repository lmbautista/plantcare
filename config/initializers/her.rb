require 'custom_token_authentication'

HER_CONFIG = YAML.load_file(File.join(Rails.root, 'config/her.yml'))

Her::API.setup url: HER_CONFIG[Rails.env] do |c|
  # Request
  # c.use CustomTokenAuthentication
  c.use Faraday::Request::UrlEncoded

  # Response
  c.use Her::Middleware::DefaultParseJSON

  # Adapter
  c.use Faraday::Adapter::NetHttp
end
