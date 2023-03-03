# frozen_string_literal: true

module Swagger
  module CustomerAccountSchema
    extend ActiveSupport::Concern
    include Swagger::Blocks

    included do
      swagger_schema :CustomerAccount do
        key :required, %i[name customer manager]
        property :id do
          key :type, :integer
          key :format, :int64
        end
        property :name do
          key :type, :string
        end
        property :customer do
          key :type, :string
        end
        property :manager do
          key :type, :string
        end
        property :team_users do
          key :type, :array
          items do
            key :type, :object
            property :id do
              key :type, :integer
              key :format, :int64
            end
            property :email do
              key :type, :string
            end
            property :start_date do
              key :type, :string
            end
            property :end_date do
              key :type, :string
            end
            property :deleted_at do
              key :type, :string
            end
          end
        end
      end

      swagger_schema :CustomerAccountInput do
        key :required, %i[name customer manager team_attributes]
        property :name do
          key :type, :string
        end
        property :customer do
          key :type, :string
        end
        property :manager do
          key :type, :string
        end
        property :team_attributes do
          key :type, :object
          key :description, 'Team'
          property :id do
            key :type, :integer
            key :format, :int64
          end
          property :team_users_attributes do
            key :type, :array
            items do
              key :type, :object
              property :id do
                key :type, :integer
                key :format, :int64
              end
              property :user_id do
                key :type, :integer
                key :format, :int64
              end
              property :start_date do
                key :type, :string
              end
              property :end_date do
                key :type, :string
              end
              property :_destroy do
                key :type, :boolean
                key :description, 'Set True for mark as deleted and fill deleted_at column'
                key :default, false
              end
            end
          end
        end
      end
    end
  end
end
