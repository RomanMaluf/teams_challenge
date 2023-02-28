# frozen_string_literal: true

class CreateCustomerAccountAndTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :customer_accounts do |t|
      t.string :name
      t.string :customer
      t.string :manager

      t.timestamps
    end

    create_table :teams do |t|
      t.belongs_to :customer_account
      t.timestamps
    end

    create_table :teams_users do |t|
      t.belongs_to :user
      t.belongs_to :team
      t.date   :start_date
      t.date   :end_date

      t.datetime   :deleted_at
      t.timestamps
    end
  end
end
