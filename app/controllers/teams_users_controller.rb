# frozen_string_literal: true

class TeamsUsersController < ApplicationController
  after_action :verify_authorized, if: :current_user
  def index
    @teams_users = policy_scope(TeamUser).unscoped.all
    authorize @teams_users

    @search = @teams_users.ransack(params[:q])
    @teams_users = @search.result(distinct: true)
  end
end