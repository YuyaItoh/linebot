# 出力先のログファイルの指定
set :output, {error: 'log/error_cron.log', standard: 'log/cron.log'}

# ジョブの実行環境の指定
set :environment, :development

# スケジュール
every 20.seconds do
  # cronのコマンドライン上で動くのでクォートで囲む
  runner 'Cron.say_something'
end