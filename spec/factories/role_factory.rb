# frozen_string_literal: true

FactoryBot.define do
  factory :role, class: 'Role' do
    user    { association(:user) }
    profile { association(:profile) }

    trait :admin do
      profile { Profile.find_by_name('Admin') || association(:profile, :admin) }
    end

    trait :super_admin do
      profile { Profile.find_by_name('SuperAdmin') || association(:profile, :super_admin) }
    end

    trait :common_user do
      profile { Profile.find_by_name('User') || association(:profile, :common_user) }
    end
    trait :with_specific_role do
      transient do
        specific_role { 'User Show' }
      end
      before(:create) do |role, evaluator|
        role.profile = FactoryBot.create(:profile, :with_specific_role, specific_role: evaluator.specific_role)
      end
    end
  end
end
