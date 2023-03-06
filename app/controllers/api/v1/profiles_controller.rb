# frozen_string_literal: true

module Api
  module V1
    class ProfilesController < BaseController
      include Swagger::ProfilesApi

      after_action :verify_authorized, if: :current_user

      def index
        @profiles = policy_scope(Profile).all
        authorize @profiles
      end
    end
  end
end
