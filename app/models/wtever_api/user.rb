module WteverApi
  class User < WteverApi::Base

    attributes :first_name, :last_name, :email, :country_code,
               :timezone, :lang, :password_confirmation, :password, :api_token, :last_healthy_checks

    custom_get :signin

    def board_connections
      return [] if last_healthy_checks.blank?

      last_healthy_checks.map do |healthy_check|
        healthy_check["created_at"].to_time
      end
    end

    def last_board_connection
      return nil if board_connections.blank?

      board_connections.first
    end
  end
end
