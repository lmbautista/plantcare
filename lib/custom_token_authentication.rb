class CustomTokenAuthentication < Faraday::Middleware
  def call(env)
    env[:request_headers]["Wtever-API-Token"] = RequestStore.store[:wtever_token] if RequestStore.store[:wtever_token]
    @app.call(env)
  end
end
