# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

b = User.create(email: "blair81@gmail.com", password: "password")
e = User.create(email: "evan@example.com", password: "password")

quickleft = Feed.add(url: "http://quickleft.com/blog.rss")
pando = Feed.add(url: "http://pando.com/feed")

if quickleft
  b.feeds << quickleft
end

if pando
  e.feeds << pando
end

FetchFeeds.new(b.feeds).fetch_all
FetchFeeds.new(e.feeds).fetch_all

messages = [
    "If you're reading this comment, then you'll probably be affected by this illness - http://www.newrepublic.com/article/119265/alzheimers-disease-statistics-show-illness-will-define-our-times/",
    "The new bionics that let us run, climb and dance http://www.ted.com/talks/hugh_herr_the_new_bionics_that_let_us_run_climb_and_dance",
    "some beautiful daytime disco - https://soundcloud.com/poolside/chillin-out-poolside-edit",
    "another rad disco mi - https://soundcloud.com/poolside/poolside-stir-it-up-mixtape"
].map { |content| {content: content} }

b.messages.create(messages)