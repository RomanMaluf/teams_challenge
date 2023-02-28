# frozen_string_literal: true

class TeamUserPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if user.admin? || user.roles_name.include?('Admin')
        scope.all
      else
        scope.none
      end
    end
  end
end
