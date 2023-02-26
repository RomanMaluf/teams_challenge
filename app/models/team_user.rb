# frozen_string_literal: true

class TeamUser < ApplicationRecord
  self.table_name = 'teams_users'
  belongs_to :team
  belongs_to :user

  has_one :customer_account, through: :team
  delegate :name, to: :customer_account

  validates_presence_of :start_date, :end_date

  scope :active, ->(date = Time.zone.today) {
    where('end_date >= ? AND start_date <= ?', date, date)
  }

  def active?
    date = Time.zone.now
    end_date >= date && start_date <= date
  end
end
