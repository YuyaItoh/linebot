# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'linebot'
set :repo_url, 'git@github.com:YuyaItoh/linebot.git'

# Default branch is :master
set :branch, 'master'

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :airbrussh.
set :format, :pretty

# You can configure the Airbrussh format using :format_options.
# These are the defaults.f
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{log}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 1

# rbenvの設定
set :rbenv_type, :user
set :rbenv_ruby, '2.2.0'

# wheneverと連動
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

# サーバ設定
server 'yy-sn.com', user: 'y-itoh', role: %w{web app db}


# タスクの設定
namespace :deploy do
end
