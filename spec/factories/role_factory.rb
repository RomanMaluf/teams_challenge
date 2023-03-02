# frozen_string_literal: true

require 'rails_helper'

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
  end
end


