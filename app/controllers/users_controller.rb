class UsersController < ApplicationController
  before_action :load_user, except: %i(new create index)
  before_action :logged_in_user, except: %i(new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @users = User.all.page params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "welcome_to_the_sample_app!"
      redirect_back_or @user
    else
      flash[:danger] = t "error.signup_fail"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "success.profile_updated"
      redirect_to @user
    else
      flash[:danger] = t "error.update_fail"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "success.user_deleted"
    else
      flash[:danger] = t "error.deleted_failed"
    end
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit User::USER_ATTRS
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "error.require_login"
    redirect_to login_url
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "error.not_found"
    redirect_to root_url
  end
end
