FactoryBot.define do
  factory :setting_general_info do
    site { nil }
    site_name { "MyText" }
    plain_text_name { "MyText" }
    text_number { "MyText" }
    newsletter_subscription_url { "MyText" }
    default_meta_blurb { "MyText" }
    is_team_website { false }
  end
end
