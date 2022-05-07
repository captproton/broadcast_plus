FactoryBot.define do
  factory :media_appearance do
    association :site
    title { "MyString" }
    published_on { "2022-05-07" }
  end
end
