set :deploy_to, "/home/y-itoh/rails/linebot"

set :ssh_options, {
  keys: %w(~/.ssh/id_rsa),
  forward_agent: true
}