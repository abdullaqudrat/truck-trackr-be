FactoryBot.define do
  factory :food_truck do
    name { Faker::AquaTeenHungerForce.character }
    food_type { Faker::Food.dish }
    contact_name { Faker::Name.first_name }
    phone { Faker::PhoneNumber.cell_phone }
    email { Faker::Internet.email }
    website { Faker::Internet.url }
    logo_image { File.new(File.join(Rails.root, 'public/test.jpeg')) }
    uid { Faker::Internet.password }
  end
end
