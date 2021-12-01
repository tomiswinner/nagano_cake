class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :last_name              , null: false
      t.string :first_name             , null: false
      t.string :last_name_kana         , null: false
      t.string :first_name_kana        , null: false
      t.string :email                  , null: false
      t.string :encrypted_password     , null: false
      t.string :postal_code            , null: false
      t.string :address                , null: false
      t.string :telephone_number       , null: false
      t.boolean :is_active             , null: false, default: TRUE
      
      t.timestamps
    end
  end
end
