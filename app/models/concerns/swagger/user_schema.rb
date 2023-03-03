# frozen_string_literal: true

module Swagger
  module UserSchema
    extend ActiveSupport::Concern
    include Swagger::Blocks

    included do
      swagger_schema :User do
        key :required, %i[name email]
        property :id do
          key :type, :integer
          key :format, :int64
        end
        property :email do
          key :type, :string
        end
        property :name do
          key :type, :string
        end
        property :english_level do
          key :type, :string
        end
        property :technical_knowledge do
          key :type, :string
        end
        property :cv_link do
          key :type, :string
        end
        property :created_at do
          key :type, :string
        end
        property :updated_at do
          key :type, :string
        end
        property :url do
          key :type, :string
        end
        property :customer_accounts do
          key :type, :array
          items do
            key :type, :object
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

      swagger_schema :UserInput do
        key :required, %i[name email]
        property :name do
          key :type, :string
        end
        property :email do
          key :type, :string
        end
        property :english_level do
          key :type, :string
        end
        property :technical_knowledge do
          key :type, :string
        end
        property :cv_link do
          key :type, :string
        end
        property :password do
          key :type, :string
          key :description, "leave blank if you don't want to change it"
        end
        property :password_confirmation do
          key :type, :string
          key :description, "leave blank if you don't want to change it"
        end
      end
    end
  end
end
