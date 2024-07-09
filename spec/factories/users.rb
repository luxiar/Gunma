FactoryBot.define do
  factory :user do
    last_name { '塚越' }
    first_name { '俊介' }
    email { 'tsukagoshi.shunsuke@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    admin { true }
  end
end
