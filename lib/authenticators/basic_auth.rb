# frozen_string_literal: true

class BasicAuth < Warden::Strategies::Base
  def valid?
    params[:email].present? && params[:password].present?
  end

  def authenticate!
    u = PlantcareApi::User.signin(email: params[:email], password: params[:password])

    if u.nil?
      fail!("Could not log in")
    else
      session[:current_user_id] = u.id
      session[:api_token] = u.api_token
      session[:lang] = u.lang

      success!(u)
    end
  end
end
