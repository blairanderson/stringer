require 'spec_helper'

describe UserStory do
  describe "associations" do
    it { should belong_to :user }
    it { should belong_to :story }
  end
end
