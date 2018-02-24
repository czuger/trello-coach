export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

cd $1

RAILS_ENV=production bundle exec rake data:retrieve 2>log/daily_rake.err >>log/daily_rake.log

RAILS_ENV=production bundle exec rake git:retrieve 2>log/git_rake.err >>log/git_rake.log
sleep 5
RAILS_ENV=production bundle exec rake git:retrieve 2>log/git_rake.err >>log/git_rake.log