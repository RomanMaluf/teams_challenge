# frozen_string_literal: true

json.extract! customer_account, :id, :name, :customer, :manager, :created_at, :updated_at

json.team do
  json.extract! customer_account.team, :id
end

json.team_users do
  json.array! customer_account.team.team_users.order(:id), partial: 'api/v1/customer_accounts/team_user', as: :team_user
end