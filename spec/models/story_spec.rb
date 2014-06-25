require 'spec_helper'

describe Story do
  it {should belong_to(:feed).dependent(:destroy)}

  describe ".add" do
    before(:each) do
      @feed = create(:feed)
    end
    it "creates a story that is attached to a feed" do
      entry = OpenStruct.new(
          title: "title",
          url: "http://quickleft.com/blog/research-firm-sourcingline-publishes-list-of-top-ruby-on-rails-developers",
          published: "Wed, 25 Jun 2014 01:39:00 -0600"
      )

      story = Story.add entry, @feed
      expect(story).to be_kind_of Story
      expect(story.feed).to eq @feed
    end
    
  end
end
