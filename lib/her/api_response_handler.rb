# frozen_string_literal: true

require "plantcare_api/forbidden_error"
require "plantcare_api/internal_server_error"
require "plantcare_api/not_found_error"

module Her
  class ApiResponseHandler < Her::Middleware::DefaultParseJSON
    def parse(body)
      json = parse_json(body)
      errors = json.delete(:errors) || []
      metadata = json.delete(:meta) || {}

      {
        data: json,
        errors: errors,
        metadata: metadata
      }
    end

    def on_complete(env)
      env[:body] = case env[:status]
                   when 204, 304
                     parse("{}")
                   when 403
                     raise PlantcareApi::ForbiddenError
                   when 404
                     raise PlantcareApi::NotFoundError
                   when 500
                     raise PlantcareApi::InternalServerError
                   else
                     parse(env[:body])
                   end
    end
  end
end
