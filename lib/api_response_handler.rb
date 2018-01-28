module ApiResponseHandler
  class WteverForbiddenError < StandardError; end
  class WteverNotFoundError < StandardError; end
  class WteverInternalServerError < StandardError; end

  class CustomerParser < Her::Middleware::JsonApiParser
    def on_complete(env)
      case env[:status]
      when 200
        parse(env[:body])
      when 403
        raise ApiResponseHandler::WteverForbiddenError
      when 404
        raise ApiResponseHandler::WteverNotFoundError
      when 500
        raise ApiResponseHandler::WteverInternalServerError
      end
    end

  end
end
