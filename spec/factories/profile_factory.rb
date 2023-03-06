# frozen_string_literal: true

FactoryBot.define do
  factory :profile, class: 'Profile' do
    sequence(:name) { |n| "User ##{n} - #{Kernel.rand(9999)}" }

    trait :admin do
      name { 'Admin' }
      permissions do
        Permission.where resource: 'User'
      end
    end

    trait :super_admin do
      name { 'SuperAdmin' }
      permissions do
        Permission.all
      end
    end

    trait :common_user do
      name { 'User' }
      permissions { [] }
    end

    trait :with_specific_role do
      transient do
        specific_role { 'User Show' }
      end
      after(:build) do |profile, evaluator|
        profile.permissions = Permission.where(name: evaluator.specific_role)
      end
    end
  end
end
