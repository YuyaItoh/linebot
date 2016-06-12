# サーバ設定
server 'yy-sn.com', user: 'y-itoh', role: %w{web app db}
set :deploy_to, "/home/y-itoh/rails/linebot"

set :ssh_options, {
  keys: %w(~/.ssh/id_rsa),
  forward_agent: true
}