# == API呼び出しクラス
class Api
  # メッセージ送信
  def self.send_message(client, to, msg)
    header = {
      "Content-Type" => "application/json; charser=UTF-8",
      'X-Line-ChannelID' => CHANNEL_ID,
      'X-Line-ChannelSecret' => CHANNEL_SECRET,
      'X-Line-Trusted-User-With-ACL' => MID
    }

    body = {
      to: [to],
      toChannel:1383378250,
      eventType:"138311608800106203",
      content: { contentType:1, toType:1, text: msg } 
    }

    # メッセージの送信
    client.post("/v1/events", body.to_json, header)
  end
end