require 'net/http'

# == LINE BOTのコールバッククラス
class CallbacksController < ApplicationController
  def callback

    # TODO: コールバックの種類による分岐処理
    # eventTypeによってmsg取得とフレンド登録が分かる
    # from とかは基本contentの中身を見ればよい

    # URI
    uri = URI.parse('https://trialbot-api.line.me')
    client = Net::HTTP.new(uri.host, 443)
    client.use_ssl = true

    # 
    # 受信
    # 
    received_body = JSON.parse(request.body.read)["result"][0]
    user = received_body["from"]

    # フレンド登録時の処理
    if received_body["opType"].present? &&  recevied_body["opType"] == 4
      # TODO Userモデルに追加する
      s_msg = "ぽんすだにゃん！"
      
      logger.debug("added as a friend -- #{user}")
    end

    # メッセージ受信時の処理
    if received_body["content"]["text"].present?
      r_msg = received_body["content"]["text"]
      s_msg = r_msg + "だにゃん"

      logger.debug("msg received -- #{r_msg}")
    end


    # 
    # 送信
    # 
    header = {
      "Content-Type" => "application/json; charser=UTF-8",
      'X-Line-ChannelID' => CHANNEL_ID,
      'X-Line-ChannelSecret' => CHANNEL_SECRET,
      'X-Line-Trusted-User-With-ACL' => MID
    }

    body = {
      to: [user],
      toChannel:1383378250,
      eventType:"138311608800106203",
      content: { contentType:1, toType:1, text: s_msg } 
    }

    client.post("/v1/events", body.to_json, header)

    render json: "{status: success}"
  end
end
