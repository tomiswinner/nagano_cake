class Item < ApplicationRecord
  attachment :image
  
  has_many :cart_items, dependent: :destroy
  has_one :order_item,  dependent: :destroy
  
  belongs_to :genre
  
  
  validates :genre_id       ,presence: true
  validates :name           ,presence: true
  validates :image_id       ,presence: true
  validates :introduction   ,presence: true
  validates :price          ,presence: true
  validates :is_active      ,presence: true
end
