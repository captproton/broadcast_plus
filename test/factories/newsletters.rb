FactoryBot.define do
  factory :newsletter do
    association :site
    title { "MyText" }
    mailing_group { "MyText" }
    sender { "MyText" }
  end
end
