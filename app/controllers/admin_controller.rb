class AdminController < ApplicationController
  def index
    redirect_to admin_login_path unless logged_in?
  end
end
