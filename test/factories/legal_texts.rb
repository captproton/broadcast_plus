FactoryBot.define do
  factory :legal_text do
    title { "MyString" }
    association :site
  end
end
