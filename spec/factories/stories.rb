# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :story do
    title { [Faker::Company.name, Faker::Company.catch_phrase].join(', ') }
    permalink {[Faker::Company.name, Faker::Company.catch_phrase].join(', ').parameterize }
    body "MyText"
    feed
    published "2014-06-25 06:42:07"
  end
end
