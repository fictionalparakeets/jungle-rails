class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with :name => ENV['HTTP_AUTH_USERNAME'], :password => ENV['HTTP_AUTH_PASSWORD']


  def show
    @product_count = Product.count

    # @category_count = Categories.count

    # [@product_count, @category_count]
    [@product_count]
  end
end
