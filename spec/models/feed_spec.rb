require 'spec_helper'

describe Feed do
  it { should validate_presence_of :url }

  it { should have_many :user_feeds }
  it { should have_many(:users).through(:user_feeds) }


  context "feed cannot be discovered" do
    let(:discoverer) { double(discover: false) }
    it "returns false if cant discover any feeds" do
      result = Feed.add({url: "http://not-a-feed.com"})

      expect(result).to be_false
    end
  end

  context "feed can be discovered" do
    let(:url) { "http://quickleft.com/blog.rss" }
    it "parses and creates the feed if discovered" do
      result = Feed.add({url: url})
      expect(result).to be_valid
      expect(result.url).to eq url
    end
  end
end
