module WteverApi
  class User < WteverApi::Base
    attributes :first_name, :last_name, :email, :country_code, :password_confirmation, :password
  end
end
