# frozen_string_literal: true

class Permission < ApplicationRecord
  scope :per_action_resource, ->(action, resource) {
    where(action: action, resource: resource)
  }
  scope :per_resource, ->(resource) {
    where(resource: resource)
  }

  has_and_belongs_to_many :profiles
  has_many :roles

  validates :name,
            presence: true,
            uniqueness: true
  validates :action,
            presence: true
  validates :resource,
            presence: true

  enum action_type: %i[register edition deletion read list].map { |e| [e, e.to_s] }.to_h

  # class << self
  #   def i18n_accion(accion)
  #     I18n.t(self.action_type.key(accion) || accion, scope: i18n_scope_for(:enums, :tipo_accion))
  #   end

  #   def i18n_scope_for(kind, scope)
  #     scope = [scope] unless scope.respond_to?(:join)

  #     [i18n_scope, kind, model_name.singular_route_key, scope].flatten * '.'
  #   end
  # end
end
