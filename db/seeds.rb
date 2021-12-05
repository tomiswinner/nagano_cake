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
