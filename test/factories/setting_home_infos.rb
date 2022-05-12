FactoryBot.define do
  factory :setting_home_info do
    association :site
    biography_blurb { "MyText" }
    video_billboard_url { "MyText" }
    watch_this_video_url { "MyText" }
    bio_link_label { "MyText" }
    watch_this_poster_url { "MyText" }
  end
end
