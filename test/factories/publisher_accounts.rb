FactoryBot.define do
  factory :publisher_account do
    name { "MyString" }
    url { "MyText" }
    font_awesome_class { "MyString" }
    network_kind { "MyString" }
    blurb { "MyString" }
    svg_logo { "MyText" }
    svg_logo_style { "MyText" }
    frontpage_ranking { 1 }
    sidebar_ranking { 1 }
    footer_ranking { 1 }
    podcast_ranking { 1 }
    association :site
  end
end
