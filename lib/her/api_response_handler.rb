require 'wtever/forbidden_error'
require 'wtever/internal_server_error'
require 'wtever/not_found_error'

module Her
  class ApiResponseHandler < Her::Middleware::DefaultParseJSON
    def parse(body)
      json = parse_json(body)
      errors = json.delete(:errors) || []
      metadata = json.delete(:meta) || {}

      {
        :data => json,
        :errors => errors,
        :metadata => metadata,
      }
    end

    def on_complete(env)
      env[:body] = case env[:status]
      when 204, 304
        parse('{}')
      when 403
        raise Wtever::ForbiddenError
      when 404
        raise Wtever::NotFoundError
      when 500
        raise Wtever::InternalServerError
      else
        parse(env[:body])
      end
    end
  end
end
