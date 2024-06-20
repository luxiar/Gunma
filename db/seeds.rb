# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

admin_user = User.create(
  first_name: 'admin',
  last_name: 'user',
  email: 'admin@example.com',
  password: 'password',
  admin: true
)

normal_user = User.create(
  first_name: 'normal',
  last_name: 'user',
  email: 'normal@example.com',
  password: 'password',
  admin: false
)

(1..10).each do |i|
  DailyReport.create(
    title: "title#{i}",
    content: "content#{i}",
    mood: i % 5,
    user_id: admin_user.id
  )
end

(1..10).each do |i|
  DailyReport.create(
    title: "title#{i}",
    content: "content#{i}",
    mood: i % 5,
    user_id: normal_user.id
  )
end

(0..10).each do |i|
  User.create(
    first_name: "normal",
    last_name: "user#{i}",
    email: "user#{i}@example.com",
    password: 'password',
    admin: false
  )
end
