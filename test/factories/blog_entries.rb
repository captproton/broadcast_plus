FactoryBot.define do
  factory :blog_entry do
    association :site
    title { "MyString" }
    pinned_value { 1 }
    publish_at { "2022-05-10 15:38:56" }
    seo_title { "MyString" }
    seo_description { "MyText" }
  end
end
