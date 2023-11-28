# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authenticator, only: %w(welcome new create confirmation)
  before_action      :set_user,      only: %w(edit)

  def welcome
    redirect_to plantcares_path if logged?
  end

  def show
  end

  def new
    @user = PlantcareApi::User.new
  end

  def create
    @user              = PlantcareApi::User.new(user_params)
    @user.wtever_token = @user.client_name = "plantcare"

    if @user.save
      redirect_to confirmation_path
    else
      flash[:error] = to_flash(@user.response_errors)

      respond_to do |format|
        format.js   { render :new and return }
        format.html { render :new and return }
      end
    end
  end

  def edit
  end

  def confirmation
  end

  def update
    @user = PlantcareApi::User.new(user_params)

    if @user.save
      flash[:notice] = I18n.t("users.update.sucessfully")
      session[:lang] = @user.lang

      redirect_to profile_user_path(@user) and return
    else
      flash[:error] = to_flash(@user.response_errors)

      render "edit" and return
    end
  end

  private

  def user_params
    params.require(:plantcare_api_user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation,
      :country_code,
      :timezone,
      :lang
    ).tap do |permitted_params|
      permitted_params[:id] = params[:id] if params[:id].present?
    end.to_h
  end

  def set_user
    @user = PlantcareApi::User.find(params[:id]) if params[:id].present?
  end
end
