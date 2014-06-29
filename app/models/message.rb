class Message < ActiveRecord::Base
  belongs_to :user
  as_enum :status, [:draft, :published]
end
