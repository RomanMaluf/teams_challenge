# frozen_string_literal: true

module Swagger
  module ProfileSchema
    extend ActiveSupport::Concern
    include Swagger::Blocks

    included do
      swagger_schema :Profile do
        property :id do
          key :type, :integer
          key :format, :int64
        end
        property :name do
          key :type, :string
        end
        property :permissions do
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
          end
        end
      end
    end
  end
end
