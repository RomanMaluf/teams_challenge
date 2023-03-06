# frozen_string_literal: true

module Api
  module V1
    class BaseController < ActionController::API
      include Pundit::Authorization

      rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

      before_action :authenticate_user_with_api_key!
      before_action :require_current_user

      def policy_scope(scope)
        Pundit.policy_scope(current_user, scope)
      end

      def authenticate_user_with_api_key!
        raise ActiveRecord::RecordNotFound, 'Invalid API-KEY' unless request.headers[:HTTP_API_KEY].present?

        user = User.find_by_api_key(request.headers[:HTTP_API_KEY])

        raise ActiveRecord::RecordNotFound, 'Invalid API-KEY' unless user

        sign_in user
      end

      private

      def require_current_user
        raise Pundit::NotAuthorizedError, 'Must be logged in' if current_user.nil?
      end

      def record_not_found(exception)
        render json: { error: exception }, status: 404
      end

      def user_not_authorized(exception)
        if exception.policy
          policy_name = exception.policy.class.to_s.underscore
          class_name = exception.record.model_name.human(count: 2)
          query = exception.query

          error_message = I18n.t "#{policy_name}.#{query}",
                                 model: class_name,
                                 scope: 'pundit',
                                 default: I18n.t("pundit.#{query}")
          render json: { error: error_message }, status: 403

        else
          render json: { error: exception }, status: 403
        end
      end
    end
  end
end
