set :ext_version, "3.1.1"
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
  upload "config/database.#{server}.yml", "#{shared_path}/config/database.yml"
end
after "deploy:setup", :setup_shared

desc "Download ExtJS"
task :download_extjs do
  run %Q{ cd #{shared_path} && curl -s -o extjs.zip "http://www.extjs.com/deploy/ext-#{ext_version}.zip" && unzip -q extjs.zip && rm extjs.zip }
end
after "deploy:setup", :download_extjs

# desc "Update Netzke"
# task :update_netzke do
#   run "git clone git://github.com/skozlov/netzke-core.git #{shared_path}/netzke-core"
#   run "git clone git://github.com/skozlov/netzke-basepack.git #{shared_path}/netzke-basepack"
# end
# after "deploy:setup", :update_netzke

desc "Update netzke plugins"
task :update_netzke, :roles => [:app] do
  run "cd #{shared_path}/netzke-basepack && git pull"
  run "cd #{shared_path}/netzke-core && git pull"
end
after "deploy:update_code", :update_netzke

desc "Do all kinds of post-update chores"
task :after_update_chores, :roles => [:app] do
  # symlink to extjs
  run "ln -s #{shared_path}/ext-#{ext_version} #{release_path}/public/extjs"
  # symlink to netzke
  run "cd #{release_path}/vendor/plugins && ln -s #{shared_path}/netzke-* ."
end
after "deploy:update_code", :after_update_chores

desc "Recreate the database from migrations"
task :db_migrate_reset, :roles => [:app] do
  run "cd #{current_path} && rake db:migrate:reset"
end