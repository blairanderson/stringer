# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

b = User.create(email: "blair81@gmail.com", password: "password")

quickleft = Feed.add(url: "http://quickleft.com/blog.rss")
if quickleft
  b.feeds << quickleft
end

hypem = Feed.add(url: "http://hypem.com/feed/loved/blairanderson/1/feed.xml")
if hypem
  b.feeds << hypem
end
