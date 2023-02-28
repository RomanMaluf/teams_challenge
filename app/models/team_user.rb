# frozen_string_literal: true

class TeamUser < ApplicationRecord
  self.table_name = 'teams_users'
  belongs_to :team
  belongs_to :user

  has_one :customer_account, through: :team
  delegate :name, to: :customer_account
  delegate :email, to: :user

  validates_presence_of :start_date, :end_date

  # Only Logic deletion!
  default_scope { where(deleted_at: nil) }

  scope :active, ->(date = Time.zone.today) {
    where('end_date >= ? AND start_date <= ?', date, date)
  }

  def self.ransackable_attributes(auth_object = nil)
    ["end_date", "start_date", "deleted_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["customer_account", "team", "user"]
  end
  def active?
    date = Time.zone.now
    end_date >= date && start_date <= date
  end

  def delete
    self.destroy
  end

  def stale_paranoid_value
    update_column :deleted_at, Time.zone.now
    clear_attribute_changes([:deleted_at])
  end

  def destroy!
    destroy || raise(
      ActiveRecord::RecordNotDestroyed.new("Failed to destroy the record", self)
    )
  end

  def destroy
    if !deleted?
      with_transaction_returning_status do
        run_callbacks :destroy do
          @_trigger_destroy_callback = true

          stale_paranoid_value
          self
        end
      end
    end
  end

  def deleted?
    !deleted_at.nil?
  end
end
