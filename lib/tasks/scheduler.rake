namespace :scheduler do
  desc 'create a job for every minute of this hour'
  task :today => :environment do
    ScheduleTracker.run_scheduler
  end

  desc 'create a job for every minute of this hour'
  task :tomorrow => :environment do
    ScheduleTracker.run_scheduler(Time.now.tomorrow)
  end


  desc 'adds schedule tracker times'
  task :seed => :environment do
    hours = Range.new(0, 23)
    minutes = Range.new(0, 59)

    hours.each do |hour|
      minutes.each do |minute|
        ScheduleTracker.where({
                                  hour: hour,
                                  minute: minute
                              }).first_or_create
      end
    end
  end
end
