require 'spec_helper'

describe Feed do
  describe "Validations" do
    before { create(:feed) }
    it { should validate_uniqueness_of :url}
    it { should validate_presence_of :url }
  end

  describe "associations" do
    it { should have_many :user_feeds }
    it { should have_many(:users).through(:user_feeds) }
  end

  describe "feed cannot be discovered" do
    let(:discoverer) { double(discover: false) }
    it "returns false if cant discover any feeds" do
      result = Feed.add({url: "http://not-a-feed.com"})

      expect(result).to be_false
    end
  end

  describe "feed can be discovered" do
    let(:url) { "http://quickleft.com/blog.rss" }
    it "parses and creates the feed if discovered" do
      result = Feed.add({url: url})
      expect(result).to be_valid
      expect(result.url).to eq url
    end
  end
end
