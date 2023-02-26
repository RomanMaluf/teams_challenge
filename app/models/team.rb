# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :team_users
  has_many :users, through: :team_users
  belongs_to :customer_account

  accepts_nested_attributes_for :team_users
  accepts_nested_attributes_for :users

  delegate :name, to: :customer_account
end
