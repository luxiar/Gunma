FactoryBot.define do
  factory :daily_report do
    title { 'title' }
    content { 'content' }
    sequence(:mood) { |i| i % 5 }

    association :user
  end
end
