FactoryBot.define do
  factory :merchandise_link do
    seller_name { "MyString" }
    item_url { "MyString" }
    association :book
    site { nil }
  end
end
