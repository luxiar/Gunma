FactoryBot.define do
  factory :user do
    last_name { 'user' }
    sequence(:first_name) { |i| "#{i}" }
    sequence(:email) { |i| "user#{i}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    admin { false }
    active { true }
  end
end
