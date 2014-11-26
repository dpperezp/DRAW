class Order < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  belongs_to :user
  
  PAYMENT_TYPES = [ "Tarjeta de Débito", "Tarjeta de Crédito"]
  validates :address, :user, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES 
  
  
  def agregar_productos_del_carrito_actual_a_esta_orden(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
