set :stage, :staging
set :application, 'c4c'
set :scm, :git
set :repo_url, 'git@github.com:adadoo/Gullak-2.git'
set :branch, "master"
set :deploy_via, :remote_cache

# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
server '54.254.187.35', user: 'ubuntu', roles: %w{web app db resque_worker}
set :ssh_options, { :forward_agent => true }
set :use_sudo, false
set :rails_env,"production"
set :deploy_to, '/home/ubuntu/apps/gullak2'

set :pty, true
set :ssh_options, { :forward_agent => true }
# set :ssh_options, {
#    keys: [File.join(ENV["HOME"], ".ssh", "id_rsa")],
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
# set :ssh_options  [File.join(ENV["HOME"], ".ssh", "id_rsa")]
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
# set :sidekiq_role, :sidekiq
# role :sidekiq, 'worker-1.acmecorp.com', 'worker-2.acmecorp.com'
# you can set custom ssh options
# it's possible to pass any option but you need to keep in mind that net/ssh understand limited list of options
# you can see them in [net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start)
# set it globally
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
# and/or per server
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
# setting per server overrides global ssh_options

# fetch(:default_env).merge!(rails_env: :staging)
