class Schedule < ActiveRecord::Base
  belongs_to :user
  has_many :schedule_times, -> { order(time: :asc) }, dependent: :destroy
  alias_method :times, :schedule_times

  DAYS = [
      :sunday,
      :monday,
      :tuesday,
      :wednesday,
      :thursday,
      :friday,
      :saturday
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

  def checked?(day)
    self.send(day) == :active ? "checked" : nil
  end

  def activate(day)
    self.update_attribute(day, :active)
  end

  def inactivate(day)
    self.update_attribute(day, :inactive)
  end
end
