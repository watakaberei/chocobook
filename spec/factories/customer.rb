# spec/factories/customer.rb

FactoryBot.define do
  factory :customer do
    email { Faker::Internet.email }
    encrypted_password { Faker::Internet.password }
    last_name { Faker::Name.last_name }
    first_name { Faker::Name.first_name }
    last_name_kana { Faker::Name.last_name } 
    first_name_kana { Faker::Name.first_name } 
    user_name { Faker::Internet.username }
    is_deleted { false }
  end
end

