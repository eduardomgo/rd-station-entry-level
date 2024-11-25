class CartsController < ApplicationController
  def show
    @cart = Cart.current_cart
    @cart.update(last_interaction_at: DateTime.now)
    render json: @cart.as_serializable_hash
  end

  def add_item
    @cart = Cart.current_cart
    @cart.add_product(params[:product_id], params[:quantity].to_i)
    @cart.update(last_interaction_at: DateTime.now)
    render json: @cart.as_serializable_hash
  end

  def remove_from_cart
    @cart = Cart.current_cart
    product = Product.find(params[:product_id])
    cart_product = @cart.cart_products.find_by(product: product)
    cart_product.destroy if cart_product
    @cart.update(last_interaction_at: DateTime.now)
    render json: @cart.as_serializable_hash
  end
end
