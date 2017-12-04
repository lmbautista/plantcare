class CustomTokenAuthentication < Faraday::Middleware
  def call(env)
    env[:request_headers]["Authorization"] = "Token token=#{RequestStore.store[:wtever_token]}"

    puts "env[:request_headers]: #{env[:request_headers].try(:inspect)}"

    @app.call(env)
  end
end
