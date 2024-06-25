# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

admin_user = User.create!(
  last_name: 'admin',
  first_name: 'user',
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password',
  admin: true
)

normal_user = User.create!(
  last_name: 'normal',
  first_name: 'user',
  email: 'normal@example.com',
  password: 'password',
  password_confirmation: 'password',
  admin: false
)

(1..5).each do |i|
  [admin_user, normal_user].each do |user|
    DailyReport.create!(
      title: "title#{i}",
      content: "content#{i}",
      mood: i % 5,
      user_id: user.id
    )
  end

  User.create!(
    last_name: 'normal',
    first_name: "user#{i}",
    email: "user#{i}@example.com",
    password: 'password',
    password_confirmation: 'password',
    admin: false,
    status: :active
  )

  User.create!(
    last_name: 'deleted',
    first_name: "user#{i + 5}",
    email: "user#{i + 5}@example.com",
    password: 'password',
    password_confirmation: 'password',
    admin: false,
    status: :retired
  )
end
