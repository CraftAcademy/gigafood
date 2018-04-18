# config valid for current version and patch releases of Capistrano
lock '~> 3.10.2'

# config/deploy.rb
set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.4.4'

set :application, 'gigafood'
set :repo_url, 'git@github.com:CraftAcademy/gigafood.git'

set :branch, ENV['BRANCH']

set :deploy_to, ENV['APP_PATH']

# Default value for :linked_files is []
set :linked_files, %w[
  config/database.yml config/secrets.yml .env config/puma.rb
]

# Default value for linked_dirs is []
set :linked_dirs, %w[
  log tmp/pids tmp/cache tmp/sockets vendor/bundle
  public/system public/uploads public/.well-known
]

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end
