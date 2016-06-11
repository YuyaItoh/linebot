set :deploy_to, "/home/y-itoh/rails/linebot"

set :ssh_options, {
  keys: [File.expand_path('~/.ssh/id_rsa/')],
  forward_agent: true
}