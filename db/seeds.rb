# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

tsukagoshi = User.create!(
  last_name: '塚越',
  first_name: '俊介',
  email: 'tsukagoshi.shunsuke@example.com',
  password: 'password',
  password_confirmation: 'password',
  admin: true
)

yoshino = User.create!(
  last_name: '吉野',
  first_name: '輝',
  email: 'yoshino.akira@example.com',
  password: 'password',
  password_confirmation: 'password',
  admin: false
)

uyama = User.create!(
  last_name: '宇山',
  first_name: '輝',
  email: 'uyama.hikaru@example.com',
  password: 'password',
  password_confirmation: 'password',
  admin: false
)

kuboki = User.create!(
  last_name: '久保木',
  first_name: '國人',
  email: 'kuboki.kunito@example.com',
  password: 'password',
  password_confirmation: 'password',
  admin: false
)

learned_tags = ['html', 'css', 'javascript', 'ruby', 'rails', 'sinatra', 'c', 'c#', 'c++', 'java', 'python', 'php'].map do |tag|
  LearnedTag.create!(name: tag)
end

(1..10).each do |i|
  [yoshino, uyama, kuboki].each do |user|
    daily_report = DailyReport.create!(
      title: "title#{i}",
      content: "content#{i}",
      mood: i % 5,
      user_id: user.id
    )

    learned_tags.sample(3).each do |tag|
      DailyReportsLearnedTag.create!(
        daily_report_id: daily_report.id,
        learned_tag_id: tag.id
      )
    end
  end
end

(1..6).each do |i|
  User.create!(
    last_name: 'normal',
    first_name: "user#{i}",
    email: "user#{i}@example.com",
    password: 'password',
    password_confirmation: 'password',
    admin: false,
    active: i.odd?
  )
end

daily_reports = [
  {
    title: '6/20',
    mood: 0,
    user_id: tsukagoshi.id,
    content: <<~CONTENT
      # 6月20日
      ## 予定
      - 管理者権限の追加
      - ユーザー一覧画面の作成
      - ユーザー新規作成画面の追加

      ## 実績
      ### 作業完了
      - 管理者権限の追加

      ### 作業未完了(達成度)
      - ユーザー一覧画面の作成
      - ユーザー新規作成画面の追加(20%)

      ## 学んだこと
      - deviseについて
      - bootstrapの使い方

      ## 所感
      - bootstrapを使うとクラスを貼るだけでいい感じにしてくれるので、慣れれば楽そうだと思いました。

      ## 次回作業予定
      - デザインを考える
      - 権限の修正
      - ユーザー新規作成画面の追加
    CONTENT
  },
  {
    title: '6/21',
    mood: 1,
    user_id: tsukagoshi.id,
    content: <<~CONTENT
      # 6月21日
      ## 予定
      - デザインを考える
      - 権限の修正
      - ユーザー新規作成画面の追加

      ## 実績
      ### 作業完了
      - デザインを考える
      - 権限の修正

      ### 作業未完了(達成度)
      - ユーザー新規作成画面の追加

      ## 学んだこと
      - bootstrapは色々なテンプレートが作成されているので、自分で考えるよりそれらに従ったほうが良さそうだなと思いました

      ## 所感
      - bootstrap、簡単にそれっぽくなるので楽しかったです。

      ## 次回作業予定
      - ユーザーの削除機能の追加
    CONTENT
  },
  {
    title: '6/24',
    mood: 2,
    user_id: tsukagoshi.id,
    content: <<~CONTENT
      # 6月24日
      ## 予定
      - ユーザーの削除機能の追加

      ## 実績
      ### 作業完了
      - ユーザー新規作成画面の追加

      ### 作業未完了(達成度)
      - ユーザーの削除機能の追加(90%)

      ## 学んだこと
      - 論理削除について
      - bootstrapについて

      ## 所感
      - 少し予定より遅れてしまっているので、遅れた原因や改善策を考えながら進めていきたいです。

      ## 次回作業予定
      - ユーザーの削除機能の追加
    CONTENT
  }
]

daily_reports.each do |daily_report|
  daily_report[:content] = daily_report[:content].gsub(/\R/, '<br>')
  DailyReport.create!(daily_report).id
end
