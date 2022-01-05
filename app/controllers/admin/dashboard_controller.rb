class Admin::DashboardController < ApplicationController
 http_basic_authenticate_with name: END["ADMIN_USERNAME_KEY"], password: ENV["ADMIN_PASSWORD_KEY"]
  def show
  end
end
