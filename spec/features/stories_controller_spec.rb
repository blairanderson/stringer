require "spec_helper"

describe StoriesController do
  let(:feed) { create(:feed) }


  describe "visit /news" do

    before do
      @story_one = create(:story, feed: feed)
      @story_two = create(:story, feed: feed)
      @user = create(:user, email: "email@example.com", password: "password")
      @user.feeds << feed
      login_user @user
    end

    it "displays list of unread stories" do
      visit stories_path
      expect(page).to have_css(".story", count: 2)
      expect(page).to have_content(@story_one.lead)
      expect(page).to have_content(@story_two.lead)
    end

    xit "displays all user actions" do
      visit stories_path

      expect(page).to have_tag("#mark-all")
      expect(page).to have_tag("#refresh")
      expect(page).to have_tag("#feeds")
      expect(page).to have_tag("#add-feed")
    end

    xit "should have correct footer links" do
      visit stories_path

      expect(page).to have_tag("a", with: { href: "/logout"})
      expect(page).to have_tag("a", with: { href: "https://waffle.io/blairanderson/stringer"})
    end
  end

  describe "visit /starred" do
    let(:starred_one) { create(:story, is_starred: true) }
    let(:starred_two) { create(:story, is_starred: true) }
    let(:stories) { [starred_one, starred_two].paginate }
    before { Story.stub(:starred).and_return(stories) }

    xit "displays the list of starred stories with pagination" do
      visit "/starred"

      page = last_response.body
      page.should have_tag("#stories")
      page.should have_tag("div#pagination")
    end
  end

  describe "visit /stories/:id/edit" do
    let(:user){ create(:user) }
    let(:story_one) { create(:story) }

    before do
      login_user user
      user.stub(:stories).and_return([story_one])
    end
    it "works as a form!" do
      visit edit_story_path(story_one)
      expect(page).to have_content story_one.entry_id
    end
  end

  describe "visit /feed/:feed_id" do
    xit "looks for a particular feed" do
      Feed.should_receive(:fetch).with(story_one.feed.id.to_s).and_return(story_one.feed)
      Story.should_receive(:feed).with(story_one.feed.id.to_s).and_return([story_one])

      visit "/feed/#{story_one.feed.id}"
    end

    xit "displays a list of stories" do
      Feed.stub(:fetch).and_return(story_one.feed)
      Story.stub(:feed).and_return(stories)

      visit "/feed/#{story_one.feed.id}"

      expect(page).to have_tag("#stories")
    end

    xit "differentiates between read and unread" do
      Feed.stub(:fetch).and_return(story_one.feed)
      Story.stub(:feed).and_return(stories)

      story_one.is_read = false
      story_two.is_read = true

      visit "/feed/#{story_one.feed.id}"

      expect(page).to have_tag('li', :class => 'story')
      expect(page).to have_tag('li', :class => 'unread')
    end
  end

  describe "visit /news/:id" do
    before do
      @story_one = create(:story, feed: feed)
      @story_two = create(:story, feed: feed)
      @user = create(:user, email: "email@example.com", password: "password")
      @user.feeds << feed
      login_user @user
    end
    it "allows the user to click title to see full article" do
      visit stories_path
      click_link @story_one.lead
      expect(page).to have_content @story_one.body
      expect(page).to have_content @story_one.lead
    end
  end
end
