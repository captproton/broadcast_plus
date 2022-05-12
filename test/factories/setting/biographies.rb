FactoryBot.define do
  factory :setting_biography, class: 'Setting::Biography' do
    site { nil }
    title { "MyText" }
  end
end
