require 'spec_helper'

describe MessagesController do
  describe 'user message queue list' do
    before do
      @user = create(:user)
      @message = create(:message, user: @user)
      login_user @user
    end

    it "displays the list" do
      by "visiting the index path" do
        visit messages_path
        expect(page).to have_content @message.content
      end

      and_by "clicking edit" do
        click_on "Edit"
        expect(current_path).to eq edit_message_path(@message)
      end
    end
  end
end