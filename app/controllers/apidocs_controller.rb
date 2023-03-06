# frozen_string_literal: true

class ApidocsController < ApplicationController
  include Swagger::Blocks
  skip_before_action :authenticate_user!

  swagger_root do
    key :swagger, '2.0'
    security_definition :api_key do
      key :type, :apiKey
      key :name, :api_key
      key :in, :header
    end
    info do
      key :version, '1.0.0'
      key :title, 'Team Challenge API'
      key :description, ' API'
      contact do
        key :name, 'https://github.com/romanmaluf'
      end
    end
    key :basePath, '/api/v1/'
    key :consumes, ['application/json']
    key :produces, ['application/json']
    tag name: 'User' do
      key :description, 'Users'
    end
    tag name: 'CustomerAccount' do
      key :description, 'Customer Accounts'
    end
    tag name: 'Profile' do
      key :description, 'Profile'
    end
  end

  # A list of all classes that have swagger_* declarations.
  SWAGGERED_CLASSES = [
    User,
    Api::V1::UsersController,
    CustomerAccount,
    Api::V1::CustomerAccountsController,
    Profile,
    Api::V1::ProfilesController,
    self
  ].freeze

  def index
    render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
  end
end
