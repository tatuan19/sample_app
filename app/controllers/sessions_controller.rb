class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    valid_password = user&.authenticate params[:session][:password]
    return login user if valid_password

    flash.now[:danger] = t "error.login_fail"
    render :new
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
