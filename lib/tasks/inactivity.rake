require 'trello'
require 'colorize'

namespace :inactivity do

  desc 'Check database for inactivity'
  task check: :environment do
    tr = TasksRecord.order('created_at DESC').pluck_to_hash(:done_count, :created_at)
    current_count = tr.shift[:done_count]
    nb_days = 0

    tr.each do |t_data|
      nb_days += 1
      break if t_data[:done_count] != current_count
    end

    config = YAML.load_file('config/mail_user_data.yml')

    if nb_days >= 3
      ReminderMailer.with(user: config[:user], nb_days: nb_days).send_reminder.deliver_now
    end
  end

end
