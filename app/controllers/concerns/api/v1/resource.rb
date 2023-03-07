# frozen_string_literal: true

module Api
  module V1
    module Resource
      extend ActiveSupport::Concern
      included do
        before_action :set_resource, only: %i[show edit update destroy]

        def index
          @resources = policy_scope(User).all
          authorize @resources, :index?
          render_serialized_payload { serialize_resource(@resources) }
        end

        def show
          authorize @resource, :show?
          render_serialized_payload { serialize_resource(@resource) }
        end

        def create
          @resource = model_class.new(permitted_resource_params)
          authorize @resource, :create?

          if @resource.save
            render_serialized_payload(201) { serialize_resource(@resource) }
          else
            render_error_payload(@resource.errors)
          end
        end

        def update
          @resource.assign_attributes(permitted_resource_params)
          authorize @resource, :update?
          if @resource.save
            render_serialized_payload { serialize_resource(@resource) }
          else
            render_error_payload(@resource.errors)
          end
        end

        def destroy
          authorize @resource, :destroy?

          render_error_payload(@resource.errors) and return unless @resource.destroy

          head 204
        end

        protected

        def policy_scope(scope)
          Pundit.policy_scope(current_user, scope)
        end

        def set_resource
          @resource = policy_scope(model_class).find(params[:id])
        end

        def resource_serializer
          "#{model_class}Serializer".constantize
        end

        def serialize_resource(resource)
          resource_serializer.new(
            resource,
            include: resource_includes
          ).serializable_hash
        end

        def render_serialized_payload(status = 200)
          render json: yield, status:
        end

        def render_error_payload(error, status = 422)
          json = if error.is_a?(ActiveModel::Errors)
                   { error: error.full_messages.to_sentence, errors: error.messages }
                 else
                   { error: }
                 end

          render json:, status:
        end
      end
    end
  end
end
