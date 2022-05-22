FactoryBot.define do
  factory :press_kit_photo_and_headshot do
    title { "MyText" }
    description { "MyText" }
    dimensions_wxh { "MyText" }
    headshot_or_other { "MyText" }
    publish_at { "2022-05-21" }
    association :setting_press_kit
  end
end
