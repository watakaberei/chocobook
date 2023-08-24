

FactoryBot.define do
  factory :recipe do
    name { Faker::Food.dish }
    introduction { Faker::Lorem.paragraph }
    cooktime { Faker::Number.between(from: 10, to: 120) }
    is_draft { false }

    after(:build) do |recipe|
      recipe.image.attach(io: File.open('spec/images/ガトーショコラ.jpg'), filename: 'ガトーショコラ.jpeg')
    end
  end
end
