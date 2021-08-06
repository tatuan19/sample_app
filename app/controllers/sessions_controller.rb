class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      if user.activated
        login user
      else
        flash[:warning] = t ".required_activate_email"
        redirect_to root_url
      end
    else
      flash.now[:danger] = t "error.login_fail"
      render :new
    end
  end

  def login user
    log_in user
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
    redirect_to user
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
