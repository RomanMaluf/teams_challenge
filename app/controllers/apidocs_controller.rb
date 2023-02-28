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
    key :basePath, '/'
    key :consumes, ['application/json']
    key :produces, ['application/json']
    tag name: 'User' do
      key :description, 'Users'
    end
  end

  # A list of all classes that have swagger_* declarations.
  SWAGGERED_CLASSES = [
      User,
      UsersController,
      self,
  ].freeze

  def index
=begin
    swagger_data = Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
    File.open(File.join(Rails.root, 'lib', 'swagger', 'swagger_v1.json'), 'w') { |file| file.write(swagger_data.to_json) }
=end
    render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
  end
end