class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item    
  
  def subtotal
    item.taxed_price * amount
  end
  
end
