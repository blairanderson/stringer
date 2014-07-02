class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_feeds
  has_many :feeds, through: :user_feeds

  has_many :user_stories
  has_many :stories, through: :feeds

  has_many :messages, -> { order(created_at: :asc) }, dependent: :destroy
  has_many :schedules
end
