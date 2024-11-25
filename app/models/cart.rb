class Cart < ApplicationRecord
  validates_numericality_of :total_price, greater_than_or_equal_to: 0

  has_many :cart_items
  has_many :products, through: :cart_items

  def update_total_price
    self.total_price = self.cart_items.sum { |cart_item| cart_item.total_price }
    self.save
  end

  def mark_as_abandoned
    self.update(abandoned: true)
  end

  def remove_if_abandoned
    self.destroy if self.abandoned?
  end

  def self.current_cart
    Cart.where(abandoned: nil).first_or_create
  end

  def add_product(product_id, quantity)
    cart_item = self.cart_items.find_by(product_id: product_id) || self.cart_items.new(product_id: product_id, cart: self)
    cart_item.quantity = cart_item.quantity.to_i + quantity
    cart_item.save
    update_total_price
  end

  def as_serializable_hash ## Instalar gem 'fast_jsonapi'
    return {
      "id": self.id,
      "total_price": self.total_price,
      "products": self.cart_items.map { |cart_item| { 
        "id": cart_item.product.id, 
        "name": cart_item.product.name, 
        "quantity": cart_item.quantity, 
        "unit_price": cart_item.product.price,
        "total_price": cart_item.total_price
        }
      }
    }
  end
end
