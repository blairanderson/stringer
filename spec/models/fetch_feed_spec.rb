require "spec_helper"

describe FetchFeed do
  describe "#fetch" do
    let(:daring_fireball) do
     double(url: "http://daringfireball.com/feed",
          last_fetched: Time.new(2013,1,1),
          stories: [],
          red!: true,
          save: true)
    end

    before do
      Story.stub(:add)
      Feed.stub(:update_last_fetched)
      Feed.stub(:set_status)
    end

    context "when feed has not been modified" do
      it "should not try to fetch posts" do
        parser = double(fetch_and_parse: 304)

        Story.should_not_receive(:add)

        FetchFeed.new(daring_fireball, parser)
      end
    end

    context "when no new posts have been added" do
      it "should not add any new posts" do
        fake_feed = double(last_modified: Time.new(2012, 12, 31))
        parser = double(fetch_and_parse: fake_feed)

        FindNewStories.any_instance.stub(:new_stories).and_return([])
        Story.should_not_receive(:add)
        FetchFeed.new(daring_fireball, parser).fetch
      end
    end

    context "when new posts have been added" do
      let(:now) { Time.now }
      let(:new_story){ double }
      let(:old_story) { double }

      let(:fake_feed) { double(last_modified: now, entries: [new_story, old_story]) }
      let(:fake_parser) { double(fetch_and_parse: fake_feed) }

      before { FindNewStories.any_instance.stub(:new_stories).and_return([new_story]) }

      it "should only add posts that are new" do
        Story.should_receive(:add).with(new_story, daring_fireball)
        Story.should_not_receive(:add).with(old_story, daring_fireball)

        FetchFeed.new(daring_fireball, fake_parser).fetch
      end

      it "should update the last fetched time for the feed" do
        daring_fireball.should_receive(:update_last_fetched).with(now)

        FetchFeed.new(daring_fireball, fake_parser).fetch
      end
    end

    context "feed status" do
      xit "sets the status to green if things are all good" do
        fake_feed = double(last_modified: Time.new(2012, 12, 31))
        parser = double(fetch_and_parse: fake_feed)

        daring_fireball.should_receive(:green!)

        FetchFeed.new(daring_fireball, parser).fetch
      end

      it "sets the status to red if things go wrong" do
        parser = double(fetch_and_parse: 404)

        daring_fireball.should_receive(:red!)

        FetchFeed.new(daring_fireball, parser).fetch
      end
    end
  end
end
