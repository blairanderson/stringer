require 'spec_helper'

describe UserTimeZonesController do

  describe "editing a user time zone" do
    let(:new_time_zone) { "Hawaii" }

    it "can be edited correct" do
      user = create(:user)
      login_user user

      by "visiting the edit page" do
        visit edit_user_time_zone_path
        expect(current_path).to eq edit_user_time_zone_path
        expect(page).to have_content t('user.time_zone', time_zone: user.time_zone)
      end

      and_by "submiting a new timezone" do
        select new_time_zone, from: "user[time_zone]"
        click_on "Update User"
        expect(page).to have_content t('user.time_zone', time_zone: new_time_zone)
      end
    end
  end
end
