# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'sidekiq_mailer'
set :repo_url, 'git@github.com:choyno/sidekiq_mailer.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call
#
set :rvm_type, :user
set :rvm_ruby_version, '2.0.0-p353'
set :rvm_custom_path, '/usr/local/rvm/'


# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/sidekiq_mailer'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true
set :ssh_options, { :forward_agent => true }

set :log_level, :info

set :linked_files, %w{config/database.yml config/database.yml}
set :linked_dirs, %w{bin log tmp vendor/bundle public/system}

SSHKit.config.command_map[:rake]  = "bundle exec rake"
SSHKit.config.command_map[:rails] = "bundle exec rails"




# Default value for :linked_files is []
#set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end



  # namespace :assets do

  #   Rake::Task['deploy:assets:precompile'].clear_actions

  #   desc 'Precompile assets locally and upload to servers'
  #   task :precompile do
  #     on roles(fetch(:assets_roles)) do
  #       run_locally do
  #         with rails_env: fetch(:rails_env) do
  #           execute 'bundle exec rake assets:precompile'
  #         end
  #       end

  #       within release_path do
  #         with rails_env: fetch(:rails_env) do
  #           upload!('./public/assets/', "#{shared_path}/public/", recursive: true)
  #         end
  #       end

  #       run_locally { execute 'rm -rf public/assets' }
  #     end
  #   end

  # end

end





