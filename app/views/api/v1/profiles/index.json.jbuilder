# frozen_string_literal: true

json.array! @profiles, partial: 'api/v1/profiles/profile', as: :profile
