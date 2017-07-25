class SessionsController < ApplicationController
    def new
      @user = WteverApi::User.new(sessions_params)
    end

    def create

    end

    private
      def sessions_params
        params.require(:wtever_api_user).permit(:email, :password)
      end
end
