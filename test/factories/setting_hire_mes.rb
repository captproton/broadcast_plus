FactoryBot.define do
  factory :setting_hire_me do
    association :site
    title { "MyText" }
    learn_more_text { "MyText" }
    learn_more_pdf_link { "MyText" }
  end
end
