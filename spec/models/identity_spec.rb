require 'spec_helper'

describe Identity do
  describe 'validations' do
    it { should validate_presence_of(:uid) }
    it { should validate_presence_of(:provider) }
    it { should validate_presence_of(:token) }

    it "should have facebook validations" do
      t = build(:identity, provider: "facebook")
      expect(t).to be_invalid

      t.expires = true
      t.expires_at = Time.now
      expect(t).to be_valid
    end

    it "should have twitter validations" do
      t = build(:identity, provider: "twitter")
      expect(t).to be_invalid

      t.secret = "tacotaco"
      expect(t).to be_valid
    end
  end
end
