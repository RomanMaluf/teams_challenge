# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable

  has_many :roles,
           dependent: :destroy,
           inverse_of: :user
  has_many :profiles,
           dependent: :destroy,
           through: :roles
  has_many :permissions,
           dependent: :destroy,
           through: :profiles

  def can_perform?(action, resource)
    condition = permission?(action, resource)

    (admin? || condition)
  end

  def permission?(action, resource)
    permissions.per_action_resource(action, resource).exists?
  end

  def admin?
    roles.map(&:name).include? 'SuperAdmin'
  end
end
