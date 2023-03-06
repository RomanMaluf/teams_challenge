# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: 'User' do
    email                 { FFaker::Internet.email }
    password              { '123123123' }
    password_confirmation { '123123123' }
    name                  { FFaker::Name.unique.name }
    english_level         { 'B1' }
    cv_link               { 'https://github.com/thoughtbot/factory_bot_rails' }
    technical_knowledge   { FFaker::Skill.tech_skill }

    roles do
      [Role.new(profile: Profile.find_by_name('User'))]
    end

    trait :admin do
      roles { [association(:role, :admin)] }
    end
    trait :super_admin do
      roles { [association(:role, :super_admin)] }
    end

    trait :with_specific_role do
      transient do
        specific_role { 'User Show' }
      end
      after(:build) do |user, evaluator|
        user.roles = [FactoryBot.create(:role, :with_specific_role, specific_role: evaluator.specific_role)]
      end
    end
  end
end
