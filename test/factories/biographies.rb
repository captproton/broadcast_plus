FactoryBot.define do
  factory :biography do
    association :site
    title { "MyString" }
    header_photo_url { "MyString" }
  end
end
