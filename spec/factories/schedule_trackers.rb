# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :schedule_tracker do
    hour 1
    minute 1
    attempts 1
    completed_at "2014-09-21 14:54:20"
  end
end
