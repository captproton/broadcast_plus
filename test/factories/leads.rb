FactoryBot.define do
  factory :lead do
    name { "MyString" }
    phone { "MyString" }
    email_address { "MyText" }
    subject { "MyText" }
    message_body { "MyText" }
  end
end
