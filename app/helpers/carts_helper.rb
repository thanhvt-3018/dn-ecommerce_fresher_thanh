module CartsHelper
  def load_cart
    @cart = session[:cart]
    @quantity = @cart.values.sum
  end

  def init_cart
    session[:cart] ||= {}
  end

  def load_products_into_cart
    @products = Product.by_ids @cart.keys
  end
end
