# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  protect_from_forgery with: :exception
  before_action :authenticate_user!

  before_action :add_cors_headers

  # To avoid swagger missing cors error.
  # TODO: add logic to this method or add rack-cors gem
  def add_cors_headers
    headers['Access-Control-Allow-Origin'] = request.headers["Origin"] || '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS, PUT, DELETE'
  end

  def after_sign_in_path_for(resource)
    if resource.roles.include?('admin') || resource.roles.include?('superadmin')
      home_index_path
    else
      user_path(resource)
    end
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    class_name = exception.record.model_name.human(count: 2)
    query = exception.query

    error_message = I18n.t "#{policy_name}.#{query}",
                           model: class_name,
                           scope: 'pundit',
                           default: I18n.t("pundit.#{query}")

    flash[:danger] = error_message
    redirect_back(fallback_location: root_path)
  end
end
