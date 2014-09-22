class ScheduleTracker < ActiveRecord::Base
  validates_presence_of :hour, :minute
  validates_uniqueness_of :hour, scope: :minute
  after_create :log_me!
  def log_me!
    message = "This should only be created one time. We should never see this! running at: [#{self.inspect}]"
    puts message
    # TODO LOG AND EMAIL SOMEONE
  end

  def self.run_scheduler(day = Time.now)
    beginning_of_day = day.beginning_of_day
    end_of_day = day.end_of_day

    self.all.each do |time_of_day|
      time = beginning_of_day + time_of_day.hour.hours + time_of_day.minute.minutes
      puts "Scheduled for #{time}"
      UpdateScheduler.new(time).delay(run_at: time).perform
    end

    self.where.not(completed_at: beginning_of_day..end_of_day).update_all(completed_at: nil)
  end

  def completed_today?
    now = Time.now
    completed_at.between?(now.beginning_of_day, now.end_of_day)
  end
end
