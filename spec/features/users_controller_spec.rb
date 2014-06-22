require "spec_helper"

describe "WelcomeController" do
  context "when a user is not logged in" do

    describe "GET /#index" do
      it "displays a form to enter your password" do
        visit root_path
        expect(current_path).to eq new_user_registration_path
        expect(page).to have_tag("form#new_user")
        expect(page).to have_field("input#password")
        expect(page).to have_field("input#password-confirmation")
        expect(page).to have_tag("input#submit")
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
      login_user(create_user)
    end

    it "should redirect any requests to first run stuff" do
      visit root_path
      expect(response.status).to eq 302
      expect(current_path).to eq "/news"

      get "/setup/password"
      expect(response.status).to eq 302
      expect(current_path).to eq "/news"
    end
  end
end
