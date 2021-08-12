# frozen_string_literal: true

require "custom_token_authentication"
require "her/api_response_handler"

Her::API.setup url: Rails.application.secrets.api_url do |c|
  # Request
  c.use Faraday::Request::Multipart
  c.use Faraday::Request::UrlEncoded
  c.use CustomTokenAuthentication
  c.use Faraday::Response::Logger

  # Response
  c.use Her::ApiResponseHandler

  # Adapter
  c.adapter Faraday::Adapter::NetHttp
end

Her::Model.class_eval do
  def as_json(options = nil)
    attributes.as_json(options)
  end
end
