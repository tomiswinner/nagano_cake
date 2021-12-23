class Address < ApplicationRecord
  belongs_to :customer
  
  validates :address         ,presence: true
  validates :name            ,presence: true
  validates :postal_code     ,presence: true
  validates :customer_id     ,presence: true
  
  def full_address
    '〒' + postal_code + ' ' + address + ' ' + name
  end
  
  
end
