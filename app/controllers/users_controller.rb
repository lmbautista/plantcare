class UsersController < ApplicationController
  def welcome
  end

  def show
  end

  def new
    @user = WteverApi::User.new
    @countries = WteverApi::Country.all
  end

  def create
    @user = WteverApi::User.new(user_params)
    @user.wtever_token = 'plantcare'
    if @user.save
      redirect_to confirmation_path
    else
      flash.now[:error] = to_flash(@user.response_errors)
      render 'new'
    end
  end

  def edit
    @user = WteverApi::User.find(params[:id])
  end

  def confirmation
  end

  def update
    p "llego update"
    @user = WteverApi::User.new(user_params)
    p "user: #{@user.attributes}"
    if @user.save
      p "user saved"
      flash.now[:error] = I18n.t('users.update.sucessfully')
      redirect_to user_profile_path(@user) and return
    else
      p "user not saved"
      flash.now[:error] = to_flash(@user.response_errors)
      render 'edit' and return
    end
  end

  private
    def user_params
      params.require(:wtever_api_user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :nif, :city, :state, :pc)
    end
end
