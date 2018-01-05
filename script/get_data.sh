. $HOME/.bashrc

cd /var/www/trello-coach/current

rbenv 2.5.0

RAILS_ENV=production bundle exec rake data:retrieve 2>>log/daily_rake.err >>log/daily_rake.log'