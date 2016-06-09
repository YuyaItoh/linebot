# 定期実行される処理を記述

class Cron
  # 天気情報の取得
  def self.fetch_weather
    # TOOD: 天気APIを叩いて気温や天気を取得する
  end

  # なんか適当にしゃべる
  def self.say_something
    Api.send_message("u09c5d823b2ae5c793995854066c7fa4d", "ぽんだにゃん")
  end 
end