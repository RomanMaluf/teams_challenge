# frozen_string_literal: true

class CustomerAccountsController < ApplicationController
  after_action :verify_authorized, if: :current_user
  before_action :set_customer, only: %i[show edit update destroy]

  def index
    @customer_accounts = policy_scope(CustomerAccount).all
    authorize @customer_accounts
  end

  def show; end

  def new
    @customer_account = CustomerAccount.new
    setup_new_team
    authorize @customer_account
  end

  def edit
    setup_new_team
  end

  def create
    @customer_account = CustomerAccount.new(customer_account_params)
    authorize @customer_account

    respond_to do |format|
      if @customer_account.save
        format.html { redirect_to customer_accounts_url, notice: 'Account was successfully created.' }
        format.json { render :edit, status: :created, location: @customer_account }
      else
        setup_new_team # user_ids doesnt render
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @customer_account.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @customer_account.update(customer_account_params)
        format.html { redirect_to customer_accounts_url, notice: 'Account was successfully updated.' }
        format.json { render :edit, status: :created, location: @customer_account }
      else
        setup_new_team # user_ids doesnt render
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @customer_account.errors, status: :unprocessable_entity }
      end
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

  def setup_new_team
    @customer_account.build_team if @customer_account.team.nil?
    @customer_account.team.team_users.build if @customer_account.team.team_users.empty?
  end
end
