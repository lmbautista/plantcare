class SessionsController < ApplicationController

  skip_before_action :authenticator, only: %w(new create)

  def new
    @user = WteverApi::User.new
  end

  def create
    @user = WteverApi::User.new(sessions_params)

    if authenticate!(:basic_auth)
      redirect_to plantcares_path and return
    else
      redirect_to root_path and return
    end
  end

  def not_found
    flash.now[:error] = I18n.t('sessions.new.not_found')
    render :new
  end

  private
    def sessions_params
      params.permit(:email, :password)
    end
end
