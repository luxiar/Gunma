json.extract! daily_report, :id, :title, :content, :mood, :created_at, :updated_at
json.url daily_report_url(daily_report, format: :json)
