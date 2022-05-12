# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

2.times do
  User.new do |user|
    user.email = Faker::Internet.email
    user.password = 'password'
    user.save
    2.times do
      user.events.build do |event|
        event.start_date = '2022-05-15'
        event.end_date = '2022-05-25'
        event.time = '000-01-01 20:53:00.000000000 +0000'
        event.address = Faker::Address.full_address
        event.theme = Faker::Game.title
        event.details = Faker::Quote.famous_last_words
        event.image_data = event.image.attach(io: File.open(Rails.root.join('app/assets/images/default_profile.jpg')), 
                      filename: 'default_image.jpg')
        event.event_type = Faker::Game.platform
        event.status = Faker::Boolean.boolean
        event.host_id = user.id
        event.save
      end
    end
  end
end

