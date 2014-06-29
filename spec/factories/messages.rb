# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    user_id 1
    content "MyText"
    status_cd 1
  end
end
