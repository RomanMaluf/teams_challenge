# frozen_string_literal: true

module Api
  module V1
    class UsersController < BaseController
      include Swagger::UsersApi
      after_action :verify_authorized, if: :current_user
      before_action :set_user, only: %i[show edit update destroy]

      def index
        @users = policy_scope(User).all
        authorize @users
      end

      def show
        render :show, status: :ok, location: @user
      end

      def create
        @user = User.new(user_params)
        authorize @user

        if @user.save
          render :show, status: :created, location: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def update
        if @user.update(user_params)
          render :show, status: :ok, location: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @user.destroy
          render json: { status: 'User was successfully destroyed.'}
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      private

      def set_user
        @user = policy_scope(User).find(params[:id])
        authorize @user
      end

      def user_params
        if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
          params[:user].delete(:password)
          params[:user].delete(:password_confirmation)
        end
        params.require(:user).permit(:email, :password, :password_confirmation, :name, :english_level, :cv_link,
                                    :technical_knowledge, roles_attributes: [ :profile_id, :id, {} ])
      end
    end
  end
end