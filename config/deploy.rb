require 'bundler/capistrano'

set :keep_releases, 2
set :application, "mrk"
set :deploy_to, "/home/deploy/#{application}"
set :rails_env, 'production'
set :branch, 'master'
server 'mrkonliner.ru', :web, :app, :db, :primary => true
set :normalize_asset_timestamps, false

set :use_sudo, false
set :user, "deploy"
set :scm, :git
set :repository, "git://github.com/ka8725/#{application}.git"
set :deploy_via, :checkout

namespace :deploy do
  desc "Restart Application"
  task :restart do
  end
end

after "deploy:update_code", :symlink_config_files
after "deploy:update", "deploy:cleanup"

desc 'create symlinks'
task :symlink_config_files do
  symlinks = {
    "#{shared_path}/config/database.yml" => "#{release_path}/config/database.yml",
    "#{shared_path}/spree" => "#{release_path}/public/spree"
  }
  run symlinks.map{|from, to| "ln -nfs #{from} #{to}"}.join(" && ")
end

