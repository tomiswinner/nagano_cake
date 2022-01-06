class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      
      t.references :customer        , null: false, foreign_key: true
      t.string :postal_code         , null: false
      t.string :address             , null: false
      t.string :name                , null: false
      t.integer :payment            , null: false
      t.integer :total_price        , null: false
      t.integer :shipping_fee       , null: false
      t.integer :status             , null: false
    
    
      t.timestamps
    end
  end
end
