# frozen_string_literal: true

json.extract! profile, :id, :name, :created_at, :updated_at
json.permissions do
  json.array! profile.permissions, partial: 'api/v1/profiles/permission', as: :permission
end