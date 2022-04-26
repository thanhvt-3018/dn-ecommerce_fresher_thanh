class Admin::SessionsController < ApplicationController
  layout "login"
  before_action :find_user, only: :create

  def new
    redirect_to admin_index_path if logged_in?
  end

  def create
    if @user&.authenticate params[:session][:password]
      if @user.admin?
        log_in @user
        flash[:success] = t "global.success.log_in"
        redirect_to admin_index_path
      else
        flash.now[:danger] = t "global.danger.not_admin"
        render :new
      end
    else
      flash.now[:danger] = t "global.danger.email_password_incorect"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to admin_login_path
  end

  private
  def find_user
    @user = User.find_by email: params.dig(:session, :email).downcase
    return if @user

    flash.now[:danger] = t "global.danger.email_not_found"
    render :new
  end
end
