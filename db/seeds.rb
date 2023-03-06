# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


n = ENV['USERS_COUNT'] || 50
n = n.to_i

admin_password = ENV['ADMIN_PASSWORD'] || '123123'

admin_user = User.create(email: 'admin@arkusnexus.com', password: admin_password )
Role.create(profile: Profile.find_by(name: 'SuperAdmin'), user: admin_user )

ca1  = CustomerAccount.new(
  name: 'Argentina',
  customer: 'Arkus',
  manager: 'Arkus'
)

ca1.save(validate: false)
ca2 = CustomerAccount.new(
  name: 'Chile',
  customer: 'Arkus',
  manager: 'Arkus'
)
ca2.save(validate: false)

team1 = Team.create!(customer_account: ca1)
team2 = Team.create!(customer_account: ca2)

puts "Creating #{n} Users "
  n.times.each do |n|
    user = User.create!(
                  email: "seed_email#{n}@gmail.com",
                  password: '123qwe',
                  name: "Seed Name#{n}",
                  english_level: 'B1'
                )
    user.roles.create(profile:  Profile.find_or_create_by(name: 'User'))
    team_user = if n.odd?
      user.team_users.new(team: team1)
    else
      user.team_users.new(team: team2)
    end

    team_user.start_date =  1.month.ago
    team_user.end_date   = 1.month.from_now
    team_user.save
  end
puts "Finish"