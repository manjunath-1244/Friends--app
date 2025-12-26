# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
set :environment, :development
set :output, "log/cron.log"

set :job_template, "/bin/bash -l -c ':job'"

every 1.day, at: '3:25 pm' do
  command %Q(
    cd /home/bitcot/Documents/friends &&
    ~/.rvm/gems/ruby-3.2.3@friends/wrappers/ruby -S bundle exec rails runner AdminReportService.send_reports
  )
end
