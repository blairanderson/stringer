class Schedule < ActiveRecord::Base
  belongs_to :user
  has_many :schedule_times, -> { order(time: :asc) }, dependent: :destroy

  DAYS = [
      :monday,
      :tuesday,
      :wednesday,
      :thursday,
      :friday,
      :saturday,
      :sunday
  ].freeze

  DAYS.each do |day|
    as_enum day, [:active, :inactive]
  end

  def toggle_day(day)
    return false unless DAYS.include?(day)
    day_state = self.send(day)
    new_day_state = day_state == :active ? :inactive : :active
    self.update_attribute(day, new_day_state)
  end
end
