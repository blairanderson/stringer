require 'spec_helper'

describe UserFeed do
  it { should belong_to :user }
  it { should belong_to :feed }
end
