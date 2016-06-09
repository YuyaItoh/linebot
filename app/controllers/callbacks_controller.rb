require 'net/http'

# == LINE BOTのコールバッククラス
class CallbacksController < ApplicationController
  def callback
    # URI
    uri = URI.parse('https://trialbot-api.line.me')
    client = Net::HTTP.new(uri.host, 443)
    client.use_ssl = true

    # 
    # 受信
    # 
    received_body = JSON.parse(request.body.read)["result"][0]
    r_msg = received_body["content"]["text"]
    user = received_body["content"]["from"]

    # 
    # 送信
    # 
    header = {
      "Content-Type" => "application/json; charser=UTF-8",
      'X-Line-ChannelID' => CHANNEL_ID,
      'X-Line-ChannelSecret' => CHANNEL_SECRET,
      'X-Line-Trusted-User-With-ACL' => MID
    }

    s_msg = r_msg + "だにゃん"

    body = {
      to: [to],
      toChannel:1383378250,
      eventType:"138311608800106203",
      content: { contentType:1, toType:1, text: r_msg } 
    }

    client.post("/v1/events", body.to_json, header)

    render json: "{status: success}"
  end
end
