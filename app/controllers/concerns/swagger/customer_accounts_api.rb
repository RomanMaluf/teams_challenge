# frozen_string_literal: true

# frozen_string_literal: true

module Swagger
  module CustomerAccountsApi
    extend ActiveSupport::Concern
    include Swagger::Blocks

    included do
      swagger_path '/customer_accounts/{id}' do
        parameter name: :id do
          key :in, :path
          key :description, 'Customer Account ID'
          key :required, true
          key :type, :integer
          key :format, :int64
        end
        operation :get do
          key :description, 'Find a customer account by ID'
          key :operationId, :find_customer_account_by_id
          key :tags, [:CustomerAccount]
          security do
            key :api_key, []
          end
          response 200 do
            key :description, 'Customer account'
            schema do
              key :'$ref', :CustomerAccount
            end
          end
        end
        operation :put do
          key :description, 'Updates CustomerAccount'
          key :operationId, :update_customer_account
          key :produces, ['application/json']
          key :tags, [:CustomerAccount]
          security do
            key :api_key, []
          end
          parameter do
            key :name, :customer_account
            key :in, :body
            key :description, 'CustomerAccount to update'
            key :required, true
            schema do
              key :'$ref', :CustomerAccountInput
            end
          end
          response 200 do
            key :description, 'customer account response'
            schema do
              key :'$ref', :CustomerAccount
            end
          end
          response :default do
            key :description, 'unexpected error'
          end
        end
        operation :delete do
          key :description, 'deletes a customer_accounts based on the ID supplied'
          key :operationId, :delete_customer_account
          key :tags, [:CustomerAccount]
          security do
            key :api_key, []
          end
          response 204 do
            key :description, 'account deleted'
          end
          response :default do
            key :description, 'unexpected error'
          end
        end
      end
      swagger_path '/customer_accounts' do
        operation :get do
          key :description, 'get all the customer accounts'
          key :operationId, :get_all_customer_accounts
          key :produces, [
            'application/json'
          ]
          key :tags, [:CustomerAccount]
          security do
            key :api_key, []
          end
          response 200 do
            key :description, 'customer_account response'
            schema do
              key :type, :array
              items do
                key :'$ref', :CustomerAccount
              end
            end
          end
          response :default do
            key :description, 'unexpected error'
          end
        end
        operation :post do
          key :description, 'Creates a new Customer Account'
          key :operationId, :add_customer_account
          key :produces, [
            'application/json'
          ]
          key :tags, [:CustomerAccount]
          security do
            key :api_key, []
          end
          parameter do
            key :name, :customer_account
            key :in, :body
            key :description, 'Customer Account to add'
            key :required, true
            schema do
              key :'$ref', :CustomerAccountInput
            end
          end
          response 200 do
            key :description, 'customer account response'
            schema do
              key :'$ref', :CustomerAccount
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
