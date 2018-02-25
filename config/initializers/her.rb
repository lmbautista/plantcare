require 'custom_token_authentication'
require 'her/api_response_handler'

HER_CONFIG = YAML.load_file(File.join(Rails.root, 'config/her.yml'))

Her::API.setup url: HER_CONFIG[Rails.env] do |c|
  # Request
  c.use Faraday::Request::Multipart
  c.use Faraday::Request::UrlEncoded
  c.use CustomTokenAuthentication
  c.use Faraday::Response::Logger

  # Response
  # c.use Her::Middleware::JsonApiParser
  c.use Her::ApiResponseHandler
  # Adapter
  c.use Faraday::Adapter::NetHttp


end
