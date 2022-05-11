FactoryBot.define do
  factory :blog_card do
    blog_list { nil }
    blog_entry { nil }
    title { "MyString" }
    pin_value { 1 }
  end
end
