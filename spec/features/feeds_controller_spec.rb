require "spec_helper"

describe FeedsController do
  before :each do
    @user = create(:user, email: "email@example.com", password: "password")
    login_user @user
  end


  describe "viewing the feed list" do
    it "shows the correct number of feeds" do
      @feed_count = 3
      @feeds = create_list(:feed, @feed_count)
      @user.feeds << @feeds

      visit feeds_path

      within("#feed-list") do
        expect(page).to have_css(".feed", count: @feed_count)
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
      fill_in "Feed URL", with: feed_url
      click_on "Create Feed"
      expect(page).to have_content t('feeds.add.flash.added_successfully')
    end

    let(:invalid_feed_url) { "http://not-a-valid-feed.com/" }
    it "returns error with invalid feed" do
      visit new_feed_path
      fill_in "Feed URL", with: invalid_feed_url
      click_on "Create Feed"

      expect(page).to have_content t('feeds.add.flash.feed_not_found_error')
    end

    describe "when the user already subscribes" do
      let(:feed_url) { "http://quickleft.com/blog/feed" }

      it "returns an error" do
        visit new_feed_path
        fill_in "Feed URL", with: feed_url
        click_on "Create Feed"

        expect(page).to have_content t('feeds.add.flash.added_successfully')

        visit new_feed_path
        fill_in "Feed URL", with: feed_url
        click_on "Create Feed"

        expect(page).to have_content t('feeds.add.flash.already_subscribed_error')
      end
    end
  end

  describe "DELETE /feeds/:feed_id" do
    xit "deletes a feed given the id" do
      FeedRepository.should_receive(:delete).with("123")

      delete "/feeds/123"
    end
  end
end
