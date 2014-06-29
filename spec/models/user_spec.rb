require 'spec_helper'

describe User do
  describe "associations" do
    it { should have_many(:user_feeds) }
    it { should have_many(:feeds).through(:user_feeds) }
    it { should have_many(:user_stories) }
    it { should have_many(:stories).through(:user_stories) }
    it { should have_many(:messages).dependent(:destroy) }
  end
end
