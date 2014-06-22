module UsersSpecHelper
  def login_user(user = nil)
    unless user
      user = FactoryGirl.create(:user, email: "example@example.com", password: 'password')
    end
    visit new_user_session_path
    within("#new_user") do
      fill_in 'Email', with: user.email
      within('.user_password') do
        fill_in 'Password', with: 'password'
      end
      click_on 'Sign in'
    end
  end
end
