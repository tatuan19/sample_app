class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "welcome_to_the_sample_app!"
      redirect_to @user
    else
      flash[:danger] = t "signup_fail"
      render :new
    end
  end

  def show
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "not_found"
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit User::USER_ATTRS
  end
end
