class SessionsController < ApplicationController
  before_action :find_user, only: :create

  def new
    return unless logged_in?

    return redirect_to admin_index_path if @current_user.admin?

    redirect_to root_path
  end

  def create
    if @user.authenticate params[:session][:password]
      log_in @user
      flash[:success] = t "global.success.log_in"

      return redirect_to admin_index_path if @user.admin?

      redirect_back_or root_path
    else
      flash.now[:danger] = t "global.danger.email_password_incorect"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private
  def find_user
    @user = User.find_by email: params.dig(:session, :email)&.downcase
    return if @user

    flash.now[:danger] = t "global.danger.email_not_found"
    render :new
  end
end
