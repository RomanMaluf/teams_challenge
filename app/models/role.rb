# frozen_string_literal: true

class Role < ApplicationRecord
  scope :per_action_resource, ->(action, resource) {
    joins(profile: :permissions)
      .where(permissions: { action: action, resource: resource })
  }

  belongs_to :profile
  belongs_to :user

  delegate :name, to: :profile

  validates :profile,
            presence: true

  validates :user,
            presence: true
end
