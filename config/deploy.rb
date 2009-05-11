set :application, "netzke-demo"
set :domain,      "netzke"
# set :domain,      "holland"
set :repository,  "git://github.com/skozlov/netzke-demo.git"
set :use_sudo,    false
set :deploy_to,   "/u/apps/#{application}"
set :scm,         "git"

role :app, domain
role :web, domain
role :db,  domain, :primary => true

namespace :deploy do
  desc "Restart Application"
  task :restart, :roles => :app do
    run "mkdir -p #{current_path}/tmp"
    run "touch #{current_path}/tmp/restart.txt"
  end
end

desc "Make the link to the DB-file"
task :make_db_link, :roles => [:app] do
  run "ln -s #{shared_path}/production.sqlite3 #{release_path}/db/production.sqlite3"
end
after "deploy:update_code", :make_db_link

desc "Recreate the database from migrations"
task :db_migrate_reset, :roles => [:app] do
  run "cd #{current_path} && rake db:migrate:reset"
end