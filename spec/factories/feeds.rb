# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :url do |n|
    "somecrazylongfeedurl#{n}"
  end
  factory :feed do
    name "MyString"
    url
    last_fetched "2014-06-22 09:07:00"
    status 1
    group_id 1
  end
end
