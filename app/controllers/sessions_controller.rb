# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticator, only: %w(new create)

  def new
    @user = WteverApi::User.new
  end

  def create
    @user = WteverApi::User.new(sessions_params)

    if authenticate!(:basic_auth)
      redirect_to(plantcares_path) && return
    else
      redirect_to(root_path) && return
    end
  end

  def destroy
    flash[:notice] = I18n.t("sessions.destroy.see_you")

    env["warden"].logout && redirect_to(root_path) && return
  end

  def not_found
    flash[:error] = I18n.t("sessions.new.not_found")
    render :new
  end

  private

  def sessions_params
    params.permit(:email, :password).to_h
  end
end
