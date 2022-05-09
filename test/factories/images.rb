FactoryBot.define do
  factory :image do
    association :site
    title { "MyString" }
  end
end
