# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticator, only: %w(new create)

  def new
    @user = PlantcareApi::User.new
  end

  def create
    @user = PlantcareApi::User.new(sessions_params)
    redirect_to(plantcares_path) && return if authenticate!(:basic_auth)

    redirect_to(root_path) && return
  end

  def destroy
    flash[:notice] = I18n.t("sessions.destroy.see_you")

    request.env["warden"].logout
    Rails.logger.debug ">>>>> destroy session"
    redirect_to(root_path) && return
  end

  def not_found # rubocop:disable Naming/PredicateName
    flash[:error] = I18n.t("sessions.new.not_found")
    render :new
  end

  private

  def sessions_params
    params.permit(:email, :password).to_h
  end
end
