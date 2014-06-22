require 'spec_helper'

describe WelcomeController do

  describe "GET 'index'" do
    it "returns http success" do
      get :index
      expect(response).to redirect_to new_user_registration_path
    end
  end

end
