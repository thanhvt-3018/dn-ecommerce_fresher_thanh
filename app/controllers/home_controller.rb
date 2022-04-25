class HomeController < ApplicationController
  def index
    @pagy, @products = pagy(Product.newest, items: Settings.pagy_item_8)
  end
end
