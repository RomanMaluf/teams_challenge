# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  # All users can edit their profile data
  def itself
    user_context.id == record.id
  end

  def show?
    itself || (super && within_scope?(record.id))
  end

  def update?
    itself || (super && within_scope?(record.id))
  end

  # Avoid, Admin and SuperAdmins, destroy itself
  def destroy?
    return false if itself

    (super && within_scope?(record.id))
  end

  def roles?
    can?(:register, 'Role')
  end

  class Scope < Scope
    def resolve
      return scope.none if user.blank? # just in case

      case user.roles_name
      when 'SuperAdmin', 'SuperAdmin-Admin'
        User.all
      when 'Admin'
        User.not_admins.or(User.where(id: user.id)) # hide other admin user for admin
      else
        User.where(id: user.id) # Only User context profile
      end
    end
  end
end
