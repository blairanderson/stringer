require 'spec_helper'

describe Feed do
  it { should validate_presence_of :url }

  it { should have_many :user_feeds }
  it { should have_many(:users).through(:user_feeds) }
end
