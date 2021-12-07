# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

    10.times do |n|
      Genre.create(name: "ジャンル#{n}")
    end
    
    10.times do |n|
      random_genre_id = rand(Genre.first.id..Genre.last.id)
      Item.create(name:"item#{n}",genre_id: random_genre_id,image_id:"aa",introduction:"#{n}",price: 100 * n, is_active: true)
    end

    10.times do |n|
      customer = Customer.new
      customer.email = "hogehoge#{n}@example.com"
      customer.password = "hogehoge#{n}"
      customer.last_name = "山田#{n}"
      customer.first_name  = "太郎#{n}"
      customer.last_name_kana = "ヤマダ#{n}"
      customer.first_name_kana = "タロウ#{n}"
      customer.postal_code = "#{n}12-3456"
      customer.address = "#{n}city"
      customer.telephone_number = "#{n}90-0000-0000"
      customer.save
      
    end