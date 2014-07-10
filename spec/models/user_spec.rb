require 'spec_helper'

describe User do
  describe "associations" do
    it { should have_many(:user_feeds) }
    it { should have_many(:feeds).through(:user_feeds) }
    it { should have_many(:user_stories) }
    it { should have_many(:stories).through(:feeds) }
    it { should have_many(:messages).dependent(:destroy) }
  end

  describe "validations" do
    it { should ensure_inclusion_of(:time_zone).in_array(ActiveSupport::TimeZone.all.map(&:name).sort.uniq) }
  end

  describe "#grouped_stories" do
    it "calls scopes and groups the stories" do
      user = create(:user)
      relation = double("ActiveRecord::Relation")
      user.should_receive(:stories).and_return(relation)
      relation.should_receive(:group_by)

      user.grouped_stories
    end
  end
end
