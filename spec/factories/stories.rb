# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :story do
    title "MyText"
    permalink "MyText"
    body "MyText"
    feed_id 1
    published "2014-06-25 06:42:07"
  end
end
