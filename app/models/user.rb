# frozen_string_literal: true

class User < ApplicationRecord
  include Swagger::UserSchema
  devise :database_authenticatable, :rememberable, :validatable

  has_many :roles,
           dependent: :destroy,
           inverse_of: :user
  accepts_nested_attributes_for :roles
  has_many :profiles,
           dependent: :destroy,
           through: :roles
  has_many :permissions,
           dependent: :destroy,
           through: :profiles

  has_many :team_users
  has_many :teams, through: :team_users

  has_many :customer_accounts, through: :teams

  scope :not_admins, -> {
    joins(:profiles).where.not(profiles: {name: ['SuperAdmin', 'Admin']})
  }

  def self.ransackable_attributes(auth_object = nil)
    ["email", "name"]
  end

  def can_perform?(action, resource)
    condition = permission?(action, resource)

    (admin? || condition)
  end

  def permission?(action, resource)
    permissions.per_action_resource(action, resource).exists?
  end

  def roles_name
    roles.map(&:name) * '-'
  end

  def admin?
    roles.map(&:name).include? 'SuperAdmin'
  end

  def active_accounts
    team_users.active
  end

  private

  def generate_api_key
    api_key = SecureRandom.urlsafe_base64
  end
end
