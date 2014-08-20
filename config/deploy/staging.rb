set :stage, :staging
set :application, 'c4c'
set :scm, :git
set :repo_url, 'git@github.com:adadoo/Gullak-2.git'
set :branch, "master"
set :deploy_via, :remote_cache

server '54.251.132.151', user: 'ubuntu', roles: %w{web app db resque_worker resque_scheduler}
set :ssh_options, { :forward_agent => true }
set :use_sudo, false
set :rails_env,"production"
set :deploy_to, '/home/ubuntu/apps/gullak2'

set :pty, true
set :ssh_options, { :forward_agent => true }
set :rvm_type, :user
set :rvm_ruby_version, '1.9.3'
set :deploy_via, :remote_cache
set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

set :bundle_gemfile, -> { release_path.join('Gemfile') }
set :bundle_dir, -> { shared_path.join('vendor/bundle') }
set :bundle_flags, '--deployment'
set :bundle_without, %w{development test}.join(' ')
set :bundle_binstubs, -> { shared_path.join('bin') }
set :bundle_roles, :all
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }
