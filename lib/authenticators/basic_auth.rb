class BasicAuth < Warden::Strategies::Base
  def valid?
    params[:email].present? && params[:password].present?
  end

  def authenticate!
    u = WteverApi::User.signin(email: params[:email], password: params[:password])
    u.nil? ? fail!("Could not log in") : success!(u)
  end
end
