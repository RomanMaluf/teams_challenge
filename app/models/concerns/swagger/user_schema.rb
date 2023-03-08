# frozen_string_literal: true

module Swagger
  module UserSchema
    extend ActiveSupport::Concern
    include Swagger::Blocks

    included do
      swagger_schema :User do
        property :data do
          key :type, :object
          property :id do
            key :type, :integer
            key :format, :int64
          end
          property :type do
            key :type, :string
          end
          property :attributes do
            key :type, :object
            property :email do
              key :type, :string
            end
            property :name do
              key :type, :string
            end
            property :english_level do
              key :type, :string
            end
            property :cv_link do
              key :type, :string
            end
            property :technical_knowledge do
              key :type, :string
            end
            property :created_at do
              key :type, :string
            end
            property :updated_at do
              key :type, :string
            end
          end
          property :relationships do
            key :type, :object
            property :customer_accounts do
              key :type, :object
              data_object
            end
            property :team_users do
              key :type, :object
              data_object
            end
          end
        end
        data_object(main_prop: :included, with_attr: true)
      end

      swagger_schema :UserInput do
        property :user do
          key :type, :object
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
          end
          property :password_confirmation do
            key :type, :string
          end
        end
      end
    end
  end
end

def data_object(main_prop: :data, data_type: :array, with_attr: false)
  property main_prop do
    key :type, data_type
    items do
      key :type, :object
      property :id do
        key :type, :integer
        key :format, :int64
      end
      property :type do
        key :type, :string
      end
      if with_attr
        property :attributes do
          key :type, :object
        end
      end
    end
  end
end
