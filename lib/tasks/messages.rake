desc ''
task :scheduler do
  ScheduleTime.all.find{|t| t.time.min == Time.now.min}

  # TODO: find all schedules for this minute.
  # make a job to tweet for each one.
end
