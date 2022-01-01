class Item < ApplicationRecord
  attachment :image
  # validates_presence_of :image
  
  has_many :cart_items, dependent: :destroy
  has_one :order_item,  dependent: :destroy
  
  belongs_to :genre
  
  
  validates :genre_id       , presence: true
  validates :name           , presence: true
  validates :image          , presence: true
  validates :introduction   , presence: true
  validates :price          , presence: true , numericality: {only_integer: true, greater_than: 0}
  validates :is_active                       , inclusion: [true,false]
  
  def taxed_price
    return (price * 1.1).to_i
  end
  
end
