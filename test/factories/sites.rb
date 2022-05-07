FactoryBot.define do
  factory :site do
    association :team
    name { "MyString" }
  end
end
