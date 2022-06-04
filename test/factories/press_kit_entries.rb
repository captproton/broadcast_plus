FactoryBot.define do
  factory :press_kit_entry do
    title { "MyText" }
    article_link { "MyText" }
    publish_on { "2022-05-21" }
    release_at { "2022-05-21 19:29:35" }
    association :setting_press_kit
  end
end
