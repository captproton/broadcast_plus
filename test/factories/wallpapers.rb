FactoryBot.define do
  factory :wallpaper do
    association :site
    name { "MyString" }
  end
end
