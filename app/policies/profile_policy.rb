class ProfilePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin? || user.can_perform?('list', 'Profile')
        scope.all
      else
        scope.none
      end
    end
  end
end
