require 'spec_helper'

describe Message do
  describe "associations" do
    it { should belong_to :user }
  end
end
