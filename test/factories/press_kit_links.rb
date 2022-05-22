FactoryBot.define do
  factory :press_kit_link do
    association :setting_press_kit
    label { "MyText" }
    url { "MyText" }
    category { "MyText" }
  end
end
