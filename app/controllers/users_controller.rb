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
      render 'new'
    else
      flash[:error] = to_flash(@user.response_errors)
      render 'new'
    end
  end

  def update
  end

  private
    def user_params
      params.require(:wtever_api_user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
