class BasicAuth < ::Warden::Strategies::Base
  def valid?
    params[:username] && params[:password]
  end

  def authenticate!
    u = User.authenticate(params[:username], params[:password])
    u.nil? ? fail!("Could not log in") : success!(u)
  end
end
