# frozen_string_literal: true

class CustomerAccount < ApplicationRecord
  include Swagger::CustomerAccountSchema
  has_one :team
  accepts_nested_attributes_for :team

  has_many :users, through: :team

  validates :name,
            presence: true,
            uniqueness: true
  validates_presence_of :manager, :customer

  before_save :at_least_one_user_team

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end

  private

  def at_least_one_user_team
    return unless users.blank?

    errors.add :users, :at_least_one
  end
end
