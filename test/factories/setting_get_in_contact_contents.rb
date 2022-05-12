FactoryBot.define do
  factory :setting_get_in_contact_content do
    association :site
    first_name { "MyText" }
    last_name { "MyText" }
    youtube_url { "MyText" }
    youtube_image_url { "MyText" }
  end
end
