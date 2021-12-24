class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  belongs_to :customer
  
  enum payment: {クレジットカード: 0, 銀行振込: 1}
  enum status: {入金待ち: 0, 入金確認: 1, 製作中: 2, 発送準備中: 3, 発送済み: 4}
  
  def get_shipping_fee
    return 800
  end
  
  def calculate_total_items_price
    cart_items =  CartItem.where(customer_id: customer_id)
    total_price = 0
    cart_items.each do |cart_item|
      total_price += cart_item.subtotal 
    end
    return total_price
  end
  
  def calculate_total_price_with_shipping
    return calculate_total_items_price + get_shipping_fee
  end
  
end
