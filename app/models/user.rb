class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_feeds
  has_many :feeds, through: :user_feeds

  has_many :user_stories
  has_many :stories, -> { includes(:user_stories).order(published: :desc) },  through: :feeds

  has_many :messages, -> { order(created_at: :asc) }, dependent: :destroy
  has_many :schedules

  def grouped_stories
    stories.group_by { |g| g.published.to_s(:pretty_day_and_month) }
  end
end
