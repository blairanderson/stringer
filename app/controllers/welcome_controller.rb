class WelcomeController < PublicController
  def index
    if current_user
      redirect_to stories_path
    else
      redirect_to new_user_registration_path
    end
  end
end
