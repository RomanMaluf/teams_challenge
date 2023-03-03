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
      end

      swagger_schema :CustomerAccountInput do
        key :required, %i[name customer manager]
        property :name do
          key :type, :string
        end
        property :customer do
          key :type, :string
        end
        property :manager do
          key :type, :string
        end
      end
    end
  end
end
