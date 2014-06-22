require "spec_helper"

describe "WelcomeController" do
  context "when a user is not logged in" do

    describe "GET #index" do
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

    # describe "GET /setup/tutorial" do
    #   let(:user) { double }
    #   let(:feeds) {[double, double]}
    #
    #   before do
    #     UserRepository.stub(fetch: user)
    #     Feed.stub(all: feeds)
    #   end
    #
    #   xit "displays the tutorial and completes setup" do
    #     CompleteSetup.should_receive(:complete).with(user).once
    #     FetchFeeds.should_receive(:enqueue).with(feeds).once
    #
    #     get "/setup/tutorial"
    #
    #     page = last_response.body
    #     page.should have_tag("#mark-all-instruction")
    #     page.should have_tag("#refresh-instruction")
    #     page.should have_tag("#feeds-instruction")
    #     page.should have_tag("#add-feed-instruction")
    #     page.should have_tag("#story-instruction")
    #     page.should have_tag("#start")
    #   end
    # end
  end

  context "when a user has been setup" do
    before do
      login_user
    end

    it "should redirect any requests to first run stuff" do
      visit root_path
      expect(current_path).to eq news_index_path

      visit new_user_registration_path
      expect(current_path).to eq news_index_path
    end
  end
end
