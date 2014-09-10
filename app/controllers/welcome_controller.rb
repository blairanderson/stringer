class WelcomeController < PublicController
  # this is simply so we have a happy place for a landing page...
  # in case we want to do some testing.

  def index
    if current_user
      redirect_to messages_path
    else
      redirect_to new_user_registration_path
    end
  end
end
