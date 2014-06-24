require "spec_helper"

describe FetchFeeds do
  describe "#fetch_all" do
    let(:feeds) { create_list(:feed, 2) }
    let(:fetch_feed1) { double({fetch: true}) }
    let(:fetch_feed2) { double({fetch: true}) }

    it "calls FetchFeed#fetch for every feed" do
      FetchFeed.should_receive(:new).with(feeds[0]).and_return(fetch_feed1)
      FetchFeed.should_receive(:new).with(feeds[1]).and_return(fetch_feed2)

      FetchFeeds.new(feeds).fetch_all
    end
  end
end
