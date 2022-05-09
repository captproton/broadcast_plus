FactoryBot.define do
  factory :event do
    association :site
    title { "MyString" }
    start_date { "2022-05-07" }
    finish_date { "2022-05-07" }
    more_info_url { "MyText" }
    location { "MyString" }
  end
end
