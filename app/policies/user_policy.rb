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

  def scope
    Pundit.policy_scope!(user_context, record)
  end

  class Scope < Scope
    def resolve
      return scope.none if user.blank? # just in case

      out = User.all

      return out if user.admin?

      out = out.where(id: user.id) # Only User context profile

      out
    end
  end
end
