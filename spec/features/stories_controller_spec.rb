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
      visit "/news"

      expect(page).to have_tag("#mark-all")
      expect(page).to have_tag("#refresh")
      expect(page).to have_tag("#feeds")
      expect(page).to have_tag("#add-feed")
    end

    xit "should have correct footer links" do
      visit "/news"

      page = last_response.body
      page.should have_tag("a", with: { href: "/feeds/export"})
      page.should have_tag("a", with: { href: "/logout"})
      page.should have_tag("a", with: { href: "https://github.com/swanson/stringer"})
    end

    xit "displays a zen-like message when there are no unread stories" do
      Story.stub(:unread).and_return([])

      visit "/news"

      expect(page).to have_tag("#zen")
    end
  end

  describe "visit /archive" do
    let(:read_one) { create(:story, is_read: true) }
    let(:read_two) { create(:story, is_read: true) }
    let(:stories) { [read_one, read_two].paginate }
    before { Story.stub(:read).and_return(stories) }

    xit "displays the list of read stories with pagination" do
      visit "/archive"

      page = last_response.body
      page.should have_tag("#stories")
      page.should have_tag("div#pagination")
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

  describe "visit /stories/:id" do
    before { Story.stub(:fetch).and_return(story_one) }
    context "is_read parameter" do
      context "when it is not malformed" do
        xit "marks a story as read" do
          Story.should_receive(:save).once

          visit "/stories/#{story_one.id}", {is_read: true}.to_json

          story_one.is_read.should eq true
        end
      end

      context "when it is malformed" do
        xit "marks a story as read" do
          Story.should_receive(:save).once

          visit "/stories/#{story_one.id}", {is_read: "malformed"}.to_json

          story_one.is_read.should eq true
        end
      end
    end

    context "keep_unread parameter" do
      context "when it is not malformed" do
        xit "marks a story as permanently unread" do
          # visit "/stories/#{story_one.id}", {keep_unread: false}.to_json
          visit "/stories/#{story_one.id}"

          story_one.keep_unread.should eq false
        end
      end

      context "when it is malformed" do
        xit "marks a story as permanently unread" do
          visit "/stories/#{story_one.id}", {keep_unread: "malformed"}.to_json

          story_one.keep_unread.should eq true
        end
      end
    end

    context "is_starred parameter" do
      context "when it is not malformed" do
        xit "marks a story as permanently starred" do
          visit "/stories/#{story_one.id}", {is_starred: true}.to_json

          story_one.is_starred.should eq true
        end
      end

      context "when it is malformed" do
        xit "marks a story as permanently starred" do
          visit "/stories/#{story_one.id}", {is_starred: "malformed"}.to_json

          story_one.is_starred.should eq true
        end
      end
    end
  end

  describe "visit /stories/mark_all_as_read" do
    xit "marks all unread stories as read and reload the page" do
      MarkAllAsRead.any_instance.should_receive(:mark_as_read).once

      visit "/stories/mark_all_as_read", story_ids: ["1", "2", "3"]

      last_response.status.should be 302
      URI::parse(last_response.location).path.should eq "/news"
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
end
