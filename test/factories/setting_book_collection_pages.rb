FactoryBot.define do
  factory :setting_book_collection_page do
    association :site
    title { "MyText" }
  end
end
