set :application, "netzke-demo"
set :domain,      "netzke-demo.writelesscode.com"
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
  run "ln -s #{shared_path}/blog.db #{release_path}/blog.db"
end
after "deploy:update_code", :make_db_link