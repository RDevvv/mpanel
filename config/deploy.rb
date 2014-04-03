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

after "deploy:restart", "deploy:restart_workers"

def rake(rake_cmd)
  rake_args = ENV['RAKE_ARGS'].to_s.split(',')

  cmd = "cd #{fetch(:latest_release)} && bundle exec #{fetch(:rake, "rake")} RAILS_ENV=#{fetch(:rails_env, "production")} #{rake_cmd}"
  cmd += "['#{rake_args.join("','")}']" unless rake_args.empty?
  run cmd
  set :rakefile, nil if exists?(:rakefile)
end

namespace :deploy do
  desc "Restart Resque Workers"
  task :restart_workers do
    rake "resque:restart_workers"
  end
end
