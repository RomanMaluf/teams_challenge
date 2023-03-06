# frozen_string_literal: true

FactoryBot.define do
  factory :team_user, class: 'TeamUser' do
    team        { association(:team) }
    user        { association(:user) }
    start_date  { 1.month.ago }
    end_date    { 1.year.from_now }

    trait :dropped do
      deleted_at { Time.zone.now }
    end
  end
end
