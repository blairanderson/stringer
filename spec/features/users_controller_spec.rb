require "spec_helper"

describe "WelcomeController" do
  describe "when a user is not logged in" do
    it "acts like a new user form" do
      visit root_path
      expect(current_path).to eq new_user_registration_path


      within("#new_user") do
        fill_in 'Email', :with => 'user@example.com'
        within('.user_password') do
          fill_in 'Password', :with => 'password'
        end
        fill_in 'Password confirmation', :with => 'password'
        click_on 'Sign up'
      end
      expect(page).to have_content t('devise.registrations.signed_up')
    end
  end
end
