class UsersController < ApplicationController
  skip_before_action :authenticator, only: %w(welcome new create confirmation)

  def welcome
    redirect_to plantcares_path if logged?
  end

  def show
  end

  def new
    @user      = WteverApi::User.new
    @countries = WteverApi::Country.all
  end

  def create
    @user              = WteverApi::User.new(user_params)
    @user.wtever_token = @user.client_name ='plantcare'

    if @user.save
      redirect_to confirmation_path
    else
      flash[:error] = to_flash(@user.response_errors)
      render 'new'
    end
  end

  def edit
    @user = WteverApi::User.find(params[:id])
  end

  def confirmation
  end

  def update
    @user = WteverApi::User.new(user_params)

    if @user.save
      flash[:notice] = I18n.t('users.update.sucessfully')

      redirect_to profile_user_path(@user) and return
    else
      flash[:error] = to_flash(@user.response_errors)
      
      render 'edit' and return
    end
  end

  private
    def user_params
      params.require(:wtever_api_user).permit(
        :first_name,
        :last_name,
        :email,
        :password,
        :password_confirmation,
        :nif,
        :city,
        :state,
        :pc)
    end
end
