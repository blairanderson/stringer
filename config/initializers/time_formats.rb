Time::DATE_FORMATS[:pretty_day_and_month] = lambda do |date|
  day_format = ActiveSupport::Inflector.ordinalize(date.day)
  date.strftime("%A #{day_format} %B") # => "April 25th, 2007"
end