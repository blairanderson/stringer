require 'spec_helper'

describe User do
  it { should have_many(:user_feeds) }
  it { should have_many(:feeds).through(:user_feeds) }
end
