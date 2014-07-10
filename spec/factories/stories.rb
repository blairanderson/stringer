# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :story do
    title { [Faker::Company.name, Faker::Company.catch_phrase].join(', ') }
    permalink {[Faker::Company.name, Faker::Company.catch_phrase].join(', ').parameterize }
    body { [Faker::Company.name, Faker::Company.catch_phrase].join(".") }
    feed
    sequence(:entry_id, 1000) {|n| [n, Faker::Company.name, Faker::Company.catch_phrase].join(', ').parameterize}
    published "2014-06-25 06:42:07"
  end
end
