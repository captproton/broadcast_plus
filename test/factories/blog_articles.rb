FactoryBot.define do
  factory :blog_article do
    association :blog_entry
    pinned_value { 1 }
    last_updated_by_id { 1 }
  end
end
