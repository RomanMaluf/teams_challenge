# frozen_string_literal: true

class ProfilesController < ApplicationController
  after_action :verify_authorized, if: :current_user
  before_action :set_profile, only: %i[show edit update destroy]

  def index
    @profiles = Profile.all
    authorize @profiles
  end

  def show; end

  def new
    @profile = Profile.new
    authorize @profile
  end

  def edit;end

  def create
    @profile = Profile.new(profile_params)
    authorize @profile
    respond_to do |format|
      if @profile_params.save
        redirect_to profile_url(@profile), notice: 'Profile was successfully created.' 
      else
        render :new, status: :unprocessable_entity 
      end
    end
  end

  def update
    respond_to do |format|
      if @profile.update(profile_params)
        redirect_to profile_url(@profile), notice: 'Profile was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  private

  def set_profile
    @profile = policy_scope(Profile).find(params[:id])
    authorize @profile
  end

  def profile_params
    params.require(:profile).permit(:name, permission_ids: [])
  end
end
