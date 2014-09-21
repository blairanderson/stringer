# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :identity do
    user nil
    provider "provider"
    uid "anotheruid"
    token "token"
  end
end
