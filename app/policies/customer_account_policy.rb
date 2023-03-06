# frozen_string_literal: true

class CustomerAccountPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      if user.admin? || user.can_perform?('list', 'CustomerAccount')
        scope.all
      else
        scope.none
      end
    end
  end
end
