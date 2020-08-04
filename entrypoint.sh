#!/bin/bash
rm -f tmp/pids/server.pid
bundle install
rake assets:clean
RAILS_ENV=production bundle exec rake assets:precompile
rake db:migrate
bundle exec rails server