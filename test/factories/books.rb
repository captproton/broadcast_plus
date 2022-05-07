FactoryBot.define do
  factory :book do
    association :site
    title { "MyString" }
    byline { "MyString" }
    description { "MyText" }
    jacket_url { "MyText" }
  end
end
