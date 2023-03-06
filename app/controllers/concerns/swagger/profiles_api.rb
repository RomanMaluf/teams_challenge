# frozen_string_literal: true

module Swagger
  module ProfilesApi
    extend ActiveSupport::Concern
    include Swagger::Blocks

    included do
      swagger_path '/profiles' do
        operation :get do
          key :description, 'get all profiles'
          key :operationId, :get_all_profiles
          key :produces, [
            'application/json'
          ]
          key :tags, [:Profile]
          security do
            key :api_key, []
          end
          response 200 do
            key :description, 'profile response'
            schema do
              key :type, :array
              items do
                key :'$ref', :Profile
              end
            end
          end
          response :default do
            key :description, 'unexpected error'
          end
        end
      end
    end
  end
end
