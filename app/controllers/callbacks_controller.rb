require 'net/http'

# + -- TODO ---------------------------------------------------------- +
# + msgを送信したuserに対してmsgを送り返す
# + ------------------------------------------------------------------ +

# == LINE BOTのコールバッククラス
class CallbacksController < ApplicationController
	def callback
		# URI
		uri = URI.parse('https://trialbot-api.line.me')
		client = Net::HTTP.new(uri.host, 443)
		client.use_ssl = true

		# メッセージの受信．JSONフォーマットは以下を参照
		# https://developers.line.me/bot-api/api-reference
		received_body = JSON.parse(request.body.read)["result"][0]
		msg = received_body["content"]["text"]
		user = received_body["content"]["from"]

		# Header
		header = {
			"Content-Type" => "application/json; charser=UTF-8",
			'X-Line-ChannelID' => CHANNEL_ID,
			'X-Line-ChannelSecret' => CHANNEL_SECRET,
			'X-Line-Trusted-User-With-ACL' => MID
		}

		# メッセージ送信用のbody
		body = {
			to: [user],
			toChannel:1383378250,
			eventType:"138311608800106203",
			content: { contentType:1, toType:1, text: (msg + "にゃん") } 
		}

		# メッセージの送信
		client.post("/v1/events", body.to_json, header)


		render json: "{hoge: fuga}"
	end
end
