# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#<User id: 1, email: "dedwards8@gmail.com", created_at: "2018-02-26 01:47:00", updated_at: "2020-03-28 16:37:40", name: "Derek Edwards", admin: true, subscribed_to_reminders: true, subscribed_to_neighborhood_updates: true>
User.create!(
    email: 'admin@example.com', 
    name: "Default User (Delete Me", 
    admin: true,
    password: "Welcome1",
    password_confirmation: "Welcome1")