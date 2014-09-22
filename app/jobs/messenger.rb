class Messenger
  def initialize(user_id)
    @user_id = user_id
    raise('missing user') if @user_id
  end

  def perform
  end
end