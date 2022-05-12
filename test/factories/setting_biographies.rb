FactoryBot.define do
  factory :setting_biography do
    association :site
    title { "MyText" }
  end
end
