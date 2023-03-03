# frozen_string_literal: true

module Api
  module V1
    class CustomerAccountsController < BaseController
      include Swagger::CustomerAccountsApi

      after_action :verify_authorized, if: :current_user
      before_action :set_customer, only: %i[show edit update destroy]

      def index
        @customer_accounts = policy_scope(CustomerAccount).all
        authorize @customer_accounts
      end

      def show
        render :show, status: :ok, location: @customer_account
      end

      def create
        @customer_account = CustomerAccount.new(customer_account_params)
        authorize @customer_account

        if @customer_account.save
          render :show, status: :created, location: @customer_account
        else
          render json: @customer_account.errors, status: :unprocessable_entity
        end
      end

      def update
        if @customer_account.update(customer_account_params)
          render :show, status: :ok, location: @customer_account
        else
          render json: @customer_account.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @customer_account.destroy
          render json: { status: 'Customer Account was successfully destroyed.'}
        else
          render json: @customer_account.errors, status: :unprocessable_entity
        end
      end

      private

      def set_customer
        @customer_account = policy_scope(CustomerAccount).find(params[:id])
        authorize @customer_account
      end
    
      def customer_account_params
        params.require(:customer_account).permit(:name, :customer, :manager,
                                                 team_attributes: [:id, { team_users_attributes: [:id, :user_id, :start_date, :end_date, :_destroy] }])
      end
    end
  end
end
