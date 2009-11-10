set :ext_version, "3.0.0"
set :application, "netzke-demo"
# set :domain,      "netzke"
set :domain,      "fl"
set :repository,  "git://github.com/skozlov/netzke-demo.git"
set :use_sudo,    false
# set :deploy_to,   "/u/apps/#{application}"
set :deploy_to,   "/var/rails/#{application}"
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

desc "Setup shared folder"
task :setup_shared do
  puts "Downloading extjs..."
  run %Q{ cd #{shared_path} && curl -s -o extjs.zip "http://extjs.cachefly.net/ext-#{ext_version}.zip" && unzip -q extjs.zip && rm extjs.zip }
  upload "config/database.#{server}.yml", "#{shared_path}/config/database.yml"
end
after "deploy:setup", :setup_shared

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