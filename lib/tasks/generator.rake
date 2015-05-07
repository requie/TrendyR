namespace :generator do
  task fake_labels: :environment do
    role = Role.find_by(name: 'venue')
    100.times do
      user = User.new do |u|
        u.email = Faker::Internet.safe_email
        u.first_name = Faker::Name.first_name
        u.last_name = Faker::Name.last_name
        u.password = Faker::Internet.password(8)
      end
      user.roles << role
      profile = Profile.new do |p|
        p.name = Faker::Name.name
        p.description_text = Faker::Lorem.paragraph(10)
        p.website = Faker::Internet.url
      end
      user.profile = profile
      user.skip_confirmation!
      user.save!
      user.entity_class.create(profile: profile)
    end
  end
end
