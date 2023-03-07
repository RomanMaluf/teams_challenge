# frozen_string_literal: true

module Api
  module V1
    class UsersController < BaseController
      include Swagger::UsersApi
      after_action :verify_authorized, if: :current_user

      private

      def model_class
        User
      end

      def permitted_resource_params
        if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
          params[:user].delete(:password)
          params[:user].delete(:password_confirmation)
        end
        params.require(:user).permit(:email, :password, :password_confirmation, :name, :english_level, :cv_link,
                                     :technical_knowledge, roles_attributes: [:profile_id, :id, {}])
      end

      def resource_includes
        %i[customer_accounts team_users]
      end
    end
  end
end
