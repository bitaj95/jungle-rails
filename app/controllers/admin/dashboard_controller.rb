class Admin::DashboardController < ApplicationController
  require 'dotenv/load'
  http_basic_authenticate_with name: ENV['BASIC_AUTH_NAME'], password: ENV['BASIC_AUTH_PASSWORD']

  def show
    @products = Product.all.order(created_at: :desc)
    @category = Category.all
  end
end
