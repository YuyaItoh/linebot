# 定期実行される処理を記述

class Cron
  # 天気情報の取得
  def self.fetch_weather
    # TOOD: 天気APIを叩いて気温や天気を取得する
  end

  # なんか適当にしゃべる
  def self.say_something
    # URI
    uri = URI.parse('https://trialbot-api.line.me')
    client = Net::HTTP.new(uri.host, 443)
    client.use_ssl = true

    # 送信 
    header = {
      "Content-Type" => "application/json; charser=UTF-8",
      'X-Line-ChannelID' => CHANNEL_ID,
      'X-Line-ChannelSecret' => CHANNEL_SECRET,
      'X-Line-Trusted-User-With-ACL' => MID
    }

    body = {
      to: ["u375db29de1dc8806fed21d85a27a057a"],
      toChannel:1383378250,
      eventType:"138311608800106203",
      content: { contentType:1, toType:1, text: "にゃー" } 
    }

    client.post("/v1/events", body.to_json, header)
  end
end