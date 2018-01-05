export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

cd /var/www/trello-coach/current

RAILS_ENV=production bundle exec rake data:retrieve 2>>log/daily_rake.err >>log/daily_rake.log