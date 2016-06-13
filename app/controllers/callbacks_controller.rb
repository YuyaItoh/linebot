require 'net/http'
require 'open-uri'

# == LINE BOTのコールバッククラス
class CallbacksController < ApplicationController
  def callback

    # 
    # https通信関連
    # 
    uri = URI.parse('https://trialbot-api.line.me')
    client = Net::HTTP.new(uri.host, 443)
    client.use_ssl = true

    header = {
      "Content-Type" => "application/json; charser=UTF-8",
      'X-Line-ChannelID' => CHANNEL_ID,
      'X-Line-ChannelSecret' => CHANNEL_SECRET,
      'X-Line-Trusted-User-With-ACL' => MID
    }

    # メッセージ送信相手
    mid = ""


    # 
    # 受信
    # 
    logger.debug("[DEBUG] JSON -----------------------")
    logger.debug(request.body.read)

    received_body = JSON.parse(request.body.read)["result"][0]


    # 
    # フレンド登録時の処理
    # 
    if received_body["content"]["opType"].present? &&  received_body["content"]["opType"] == 4

      profile_mid = received_body["content"]["params"][0]
      profile_uri = "https://trialbot-api.line.me/v1/profiles?mids=#{profile_mid}"

      # GETメソッド
      response = JSON.parse(open(profile_uri, header).read)

      # 名前とmidを取得
      name = response["contacts"][0]["displayName"]
      mid = response["contacts"][0]["mid"]

      # DBに追加
      logger.debug("[DEBUG] added as a friend -- #{name}, #{user}")
    end


    # 
    # メッセージ受信時の処理
    # 
    if received_body["content"]["text"].present?
      mid = received_body["content"]["from"]
      r_msg = received_body["content"]["text"]
      s_msg = r_msg + "だにゃん"

      logger.debug("[DEBUG] msg received -- #{r_msg}")
    end


    # 
    # 送信
    # 
    body = {
      to: [mid],
      toChannel:1383378250,
      eventType:"138311608800106203",
      content: { contentType:1, toType:1, text: s_msg } 
    }

    client.post("/v1/events", body.to_json, header)

    render json: "{status: success}"
  end
end
