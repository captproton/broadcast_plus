FactoryBot.define do
  factory :setting_press_kit do
    association :site
    hero_title { "MyText" }
    name { "MyText" }
    birthdate { "2022-05-12" }
    birthplace { "MyText" }
  end
end
