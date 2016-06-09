require 'net/http'

# == LINE BOTのコールバッククラス
class CallbacksController < ApplicationController
  def callback
    # URI
    uri = URI.parse('https://trialbot-api.line.me')
    client = Net::HTTP.new(uri.host, 443)
    client.use_ssl = true

    # 受信
    # received_body = JSON.parse(request.body.read)["result"][0]
    received_body = JSON.parse(File.read("test.json"))["result"][0]
    r_msg = received_body["content"]["text"]
    user = received_body["content"]["from"]
    s_msg = r_msg + "だにゃん"

    # 送信
    Api.send_message(client, user, s_msg)

    render json: "{status: success}"
  end
end
