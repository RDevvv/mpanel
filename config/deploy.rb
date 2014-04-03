require 'capistrano-db-tasks'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# set :deploy_to, '/home/ubuntu/apps'


# set :user,"ubuntu"
# server "ec2-54-211-119-149.compute-1.amazonaws.com.com", :app, :web, :db, :primary => true
# set :ssh_options, { :forward_agent => true }
# set :format, :pretty
# set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

namespace :deploy do

    desc 'Restart application'
    task :restart do
        on roles(:app), in: :sequence, wait: 5 do
            # Your restart mechanism here, for example:
            execute :touch, release_path.join('tmp/restart.txt')
        end
    end

    after :restart, :clear_cache do
        on roles(:web), in: :groups, limit: 3, wait: 10 do
            # Here we can do anything such as:
            # within release_path do
            #   execute :rake, 'cache:clear'
            # end
        end
    end
    after :finishing, 'deploy:cleanup'
end

after "deploy:restart", "resque:restart"

role :resque_worker, "app_domain"
role :resque_scheduler, "app_domain"

set :workers, { "sms_queue" => 1 }

# Uncomment this line if your workers need access to the Rails environment:
set :resque_environment_task, true
