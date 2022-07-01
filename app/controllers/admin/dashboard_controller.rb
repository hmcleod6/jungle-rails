class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: "Jungle", password: "book", except: :index
  def show
  end
end
