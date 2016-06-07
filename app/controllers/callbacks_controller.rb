require 'net/http'

# == LINE BOTのコールバッククラス
class CallbacksController < ApplicationController
	def callback
		# URI
		uri = URI.parse('https://trialbot-api.line.me')
		client = Net::HTTP.new(uri.host, 443)
		client.use_ssl = true

		# Header
		header = {
			"Content-Type" => "application/json; charser=UTF-8",
			'X-Line-ChannelID' => CHANNEL_ID,
			'X-Line-ChannelSecret' => CHANNEL_SECRET,
			'X-Line-Trusted-User-With-ACL' => MID
		}

		# メッセージ送信用のbody
		body = {
			to: ["u09c5d823b2ae5c793995854066c7fa4d"],
			toChannel:1383378250,
			eventType:"138311608800106203",
			content: { contentType:1, toType:1, text: "ほげ" } 
		}

		# メッセージ送信はpostメソッド
		# 他にもGETのAPIでいろいろと情報をとることもできるみたい...
		res = client.post("/v1/events", body.to_json, header)


		# resはこんな感じ
		# {"failed":[],"messageId":"1234567890123","timestamp":1234567890123,"version":1}
		# 送信先のMIDが違うと
		# {"statusCode":"401","statusMessage":"INVALID_MID"}
		# が返ってくる
		puts res.body

		render json: "{hoge: fuga}"
	end
end
