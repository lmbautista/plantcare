class SessionsController < ApplicationController
    def new
    end

    def create
      @user = WteverApi::User.new(sessions_params)
      if authenticate!(:basic_auth)
        redirect_to plantcares_path and return
      else
        redirect_to root_path and return
      end
    end

    private
      def sessions_params
        params.permit(:email, :password)
      end
end
