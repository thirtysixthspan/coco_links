require "config/database"

set :application, "coco_links"
set :repository,  "git@github.com:thirtysixthspan/coco_links.git"

set :template_dir, "config/"
set :scm, :git
set :deploy_to, "/srv/www/o.okccoco.com"
set :user,"deployer"

server "o.okccoco.com", :app, :web, :db, :primary => true

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end   
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
