class JobBuilder
  def initialize
    @today = Schedule::DAYS[Date.today.wday]
    @schedules = Schedule.where("#{@today.to_s}_cd" => Schedule.send("#{@today}s")[:active])
  end

  def times
    @times ||= @schedules.map(&:times).flatten.select { |t| t.time.min == Time.now.min }
  end
end