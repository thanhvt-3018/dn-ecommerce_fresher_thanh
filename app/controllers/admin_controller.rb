class AdminController < ApplicationController
  layout "admin"
  before_action :require_login, :check_admin

  def index; end

  private

  def require_login
    return if user_signed_in?

    flash[:danger] = t "global.danger.log_in"
    redirect_to new_user_session_path
  end

  def check_admin
    return if @current_user.admin?

    flash[:danger] = t "global.danger.not_admin"
    redirect_to root_path
  end
end
