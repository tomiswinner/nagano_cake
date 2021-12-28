class OrderItem < ApplicationRecord
  
  belongs_to :order
  belongs_to :item
  
  enum status: {着手不可: 0, 製作待ち: 1, 製作中: 2, 製作完了: 3}
  
  def get_item_name
    item = Item.find(item_id)
    return item.name
  end
end
