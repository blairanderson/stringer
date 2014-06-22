require "spec_helper"

describe "FeedsController" do

  before :each do
    @user = create(:user, email: "email@example.com", password: "password")
    login_user @user
  end
  let(:feed_count) { 3 }
  let(:feeds) { create_list(:feed, feed_count) }

  describe "viewing the feed list" do
    it "shows the correct number of feeds" do
      User.any_instance.should_receive(:feeds).and_return(feeds)

      visit feeds_path

      expect(page).to have_css("ul#feed-list")
      expect(page).to have_css("li.feed", count: feed_count)
    end

    it "displays message to add feeds if there are none" do
      visit feeds_path
      expect(page).to have_css "#add-some-feeds"
    end
  end

  describe "new feed view" do
    it "works" do
      visit new_feed_path
      expect(page).to have_css "form#new_feed"
    end
  end

  describe "creating a feed" do
    describe "when a feed url is valid" do
      let(:feed_url) { "http://example.com/" }
      let(:feed_name) { "New Feed" }

      it "adds the feed and queues it to be fetched" do
        AddNewFeed.should_receive(:add).with(feed_url).and_return(valid_feed)
        FetchFeeds.should_receive(:enqueue).with([valid_feed])

        visit new_feed_path
        fill_in "Name", with: feed_name
        fill_in "Url", with: feed_url
        click_on "Submit Feed"

        expect(page).to have_content "Feed Created"
      end
    end

    context "when the feed url is invalid" do
      let(:feed_url) { "http://not-a-valid-feed.com/" }

      xit "adds the feed and queues it to be fetched" do
        AddNewFeed.should_receive(:add).with(feed_url).and_return(false)

        post "/feeds", feed_url: feed_url

        page = last_response.body
        page.should have_tag(".error")
      end
    end

    context "when the feed url is one we already subscribe to" do
      let(:feed_url) { "http://example.com/" }
      let(:invalid_feed) { double(valid?: false) }

      xit "adds the feed and queues it to be fetched" do
        AddNewFeed.should_receive(:add).with(feed_url).and_return(invalid_feed)

        post "/feeds", feed_url: feed_url

        page = last_response.body
        page.should have_tag(".error")
      end
    end
  end



  describe "GET /feeds/:feed_id/edit" do
    xit "fetches a feed given the id" do
      feed = Feed.new(name: 'Rainbows and unicorns', url: 'example.com/feed')
      FeedRepository.should_receive(:fetch).with("123").and_return(feed)

      get "/feeds/123/edit"

      last_response.body.should include('Rainbows and unicorns')
      last_response.body.should include('example.com/feed')
    end
  end

  describe "PUT /feeds/:feed_id" do
    xit "updates a feed given the id" do
      feed = FeedFactory.build(url: 'example.com/atom')
      FeedRepository.should_receive(:fetch).with("123").and_return(feed)
      FeedRepository.should_receive(:update_url).with(feed, 'example.com/feed')

      put "/feeds/123", feed_id: "123", feed_url: "example.com/feed"

      last_response.should be_redirect
    end
  end

  describe "DELETE /feeds/:feed_id" do
    xit "deletes a feed given the id" do
      FeedRepository.should_receive(:delete).with("123")

      delete "/feeds/123"
    end
  end

  describe "GET /feeds/import" do
    xit "displays the import options" do
      get "/feeds/import"

      page = last_response.body
      page.should have_tag("input#opml_file")
      page.should have_tag("a#skip")
    end
  end

  describe "POST /feeds/import" do
    let(:opml_file) { Rack::Test::UploadedFile.new("spec/sample_data/subscriptions.xml", "application/xml") }

    xit "parse OPML and starts fetching" do
      ImportFromOpml.should_receive(:import).once

      post "/feeds/import", {"opml_file" => opml_file}

      last_response.status.should be 302
      URI::parse(last_response.location).path.should eq "/setup/tutorial"
    end
  end

  describe "GET /feeds/export" do
    let(:some_xml) { "<xml>some dummy opml</xml>"}
    before { Feed.stub(:all) }

    xit "returns an OPML file" do
      ExportToOpml.any_instance.should_receive(:to_xml).and_return(some_xml)

      get "/feeds/export"

      last_response.body.should eq some_xml
      last_response.header["Content-Type"].should include 'application/xml'
      last_response.header["Content-Disposition"].should == "attachment; filename=\"stringer.opml\""
    end
  end
end
