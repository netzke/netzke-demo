set :application, "netzke-demo"
set :domain,      "netzke"
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

desc "Do all kinds of post-update chores"
task :after_update_chores, :roles => [:app] do
  # symlink to extjs
  run "ln -s #{shared_path}/ext-3.0.0 #{release_path}/public/extjs"
end
after "deploy:update_code", :after_update_chores

desc "Recreate the database from migrations"
task :db_migrate_reset, :roles => [:app] do
  run "cd #{current_path} && rake db:migrate:reset"
end