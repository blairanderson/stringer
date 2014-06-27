require "spec_helper"

describe FeedsController do

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

      expect(page).to have_css(".list-group")
      within("#feed-list") do
        expect(page).to have_css(".list-group-item", count: feed_count)
      end
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
    let(:feed_url) { "http://feeds.feedburner.com/ThingsiwantToRemember" }
    it "works with a valid feed" do
      visit new_feed_path
      fill_in "Url", with: feed_url
      click_on "Create Feed"
      expect(page).to have_content t('models.feed.created')
    end

    let(:invalid_feed_url) { "http://not-a-valid-feed.com/" }
    it "returns error with invalid feed" do
      visit new_feed_path
      fill_in "Url", with: invalid_feed_url
      click_on "Create Feed"

      expect(page).to have_content t('models.not_found')
    end

    describe "when the user already subscribes" do
      let(:feed_url) { "http://quickleft.com/blog/feed" }

      it "returns an error" do
        visit new_feed_path
        fill_in "Url", with: feed_url
        click_on "Create Feed"

        expect(page).to have_content t('models.feed.created')

        visit new_feed_path
        fill_in "Url", with: feed_url
        click_on "Create Feed"

        expect(page).to have_content t('models.feed.exists')
      end
    end
  end

  describe "viewing a feed" do
    it "is able to be fetched"
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
    let(:some_xml) { "<xml>some dummy opml</xml>" }
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
