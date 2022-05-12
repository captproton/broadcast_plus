FactoryBot.define do
  factory :setting_podcast do
    association :site
    hero_title { "MyText" }
    title { "MyText" }
    podcast_player_src { "MyText" }
  end
end
