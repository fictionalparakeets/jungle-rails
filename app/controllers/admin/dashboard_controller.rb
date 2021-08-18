class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with :name => ENV['HTTP_AUTH_USERNAME'], :password => ENV['HTTP_AUTH_PASSWORD']


  def show
    @category_count = Category.count
    @product_count = Product.count

    [@product_count, @category_count]
  end
end
