class CustomTokenAuthentication < Faraday::Middleware
  def call(env)
    env[:request_headers]["Authorization"] = "Token token=#{RequestStore.store[:wtever_token]}"

    @app.call(env)
  end
end
