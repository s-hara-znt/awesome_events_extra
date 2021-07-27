# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Event.destroy_all
Ticket.destroy_all

10.times do |user_num|
  User.create(uid: "#{user_num}", provider: "github", name: "name #{user_num}", image_url: "https://avatars.githubusercontent.com/u/87514709?v=4")
  5.times do |event_num|
    Event.create(owner_id: User.find_by(uid: user_num).id, name: "event # #{event_num}", place: "place #{event_num}", start_at: Time.new + (60 * 60), end_at: Time.new + (60 * 60 * 2), content: "content #{event_num}")
  end
end

Event.all.ids.sort.each do |event_id|
  User.all.ids.sort.each do |user_id|
    Ticket.create(user_id: user_id, event_id: event_id, comment: "User #{user_id} sample comment")
  end
end
