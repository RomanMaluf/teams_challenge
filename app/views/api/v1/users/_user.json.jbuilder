# frozen_string_literal: true

json.extract! user, :id, :email, :name, :english_level, :technical_knowledge, :cv_link ,:created_at, :updated_at
json.url user_url(user, format: :json)

json.customer_accounts do
  json.array! user.team_users, partial: 'api/v1/users/customer_account', as: :customer_account
end