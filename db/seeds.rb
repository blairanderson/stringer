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
