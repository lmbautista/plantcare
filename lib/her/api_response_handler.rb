module Her
  class WteverForbiddenError < StandardError; end
  class WteverNotFoundError < StandardError; end
  class WteverInternalServerError < StandardError; end

  class ApiResponseHandler < Her::Middleware::ParseJSON
    def parse(body)
      json = parse_json(body)

      {
        :data => json[:data] || {},
        :errors => json[:errors] || [],
        :metadata => json[:meta] || {},
      }
    end

    def on_complete(env)
      env[:body] = case env[:status]
      when 204, 304
        parse('{}')
      when 403
        raise WteverForbiddenError
      when 404
        raise WteverNotFoundError
      when 500
        raise WteverInternalServerError
      else
        parse(env[:body])
      end
    end
  end
end
