# frozen_string_literal: true

require "plantcare_api/forbidden_error"
require "plantcare_api/internal_server_error"
require "plantcare_api/not_found_error"

module Her
  class ApiResponseHandler < Her::Middleware::DefaultParseJSON
    def parse(body, pagination_headers)
      json = parse_json(body)
      errors = json.delete(:errors) || []
      pagination_json = to_pagination_params(pagination_headers)

      {
        data: json,
        errors: errors,
        metadata: pagination_json
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
                     pagination_headers = env[:response_headers].slice(*PAGINATION_HEADERS.values)
                     parse(env[:body], pagination_headers)
                   end
    end

    PAGINATION_HEADERS = {
      total_count: "x-total-count",
      total_pages: "x-total-pages",
      current_count: "x-current-count",
      current_page: "x-current-page",
      per_page: "x-per-page"
    }.freeze

    private_constant :PAGINATION_HEADERS

    def to_pagination_params(pagination_headers)
      {}.tap do |params|
        PAGINATION_HEADERS.map do |k, header_key|
          params[k] = pagination_headers[header_key]
        end
      end
    end
  end
end
