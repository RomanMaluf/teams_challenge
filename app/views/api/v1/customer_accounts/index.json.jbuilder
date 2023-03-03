# frozen_string_literal: true

json.array! @customer_accounts, partial: 'api/v1/customer_accounts/customer_account', as: :customer_account
