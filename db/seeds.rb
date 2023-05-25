# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create!(
   name: "ケーキ",
)

Category.create!(
   name: "焼菓子",
)

Category.create!(
   name: "生チョコレート",
)

Category.create!(
   name: "ボンボンショコラ",
)

Category.create!(
   name: "ベーカリー",
)

Category.create!(
   name: "その他",
)

Admin.create!(
   email: "email@email", password: "password"
)