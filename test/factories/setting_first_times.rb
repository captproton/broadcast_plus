FactoryBot.define do
  factory :setting_first_time do
    association :site
    first_name { "MyText" }
    last_name { "MyText" }
    blurb { "MyText" }
    twitter_handle { "MyText" }
    featured_image_src { "MyText" }
    featured_youtube_video_url { "MyText" }
  end
end
