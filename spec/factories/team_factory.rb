# frozen_string_literal: true

FactoryBot.define do
  factory :team, class: 'Team' do
    customer_account { association(:customer_account, team: self.instance) }
    team_users do
      [
        TeamUser.new(start_date: Time.zone.now, end_date: 1.year.from_now, user: create(:user) ),
        TeamUser.new(start_date: Time.zone.now, end_date: 1.year.from_now, user: create(:user) ),
        TeamUser.new(start_date: Time.zone.now, end_date: 1.year.from_now, user: create(:user) )
      ]
    end
  end
end
