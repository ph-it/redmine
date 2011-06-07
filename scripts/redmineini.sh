#!/bin/sh

. /opt/bitnami/scripts/setenv.sh
cd /opt/bitnami/apps/redmine-1.1.2
rake config/initializers/session_store.rb
rake db:migrate RAILS_ENV="production"
echo en | rake redmine:load_default_data RAILS_ENV="production"
