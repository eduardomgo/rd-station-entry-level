class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates_numericality_of :quantity, greater_than: 0

  after_save :update_cart_total_price
  after_destroy :update_cart_total_price

  def update_cart_total_price
    self.cart.update_total_price
  end

  def total_price
    self.quantity * self.product.price
  end
end
