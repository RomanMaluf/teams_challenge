# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def user_context
    @user
  end

  def index?
    can?(:list)
  end

  def show?
    can?(:read)
  end

  def create?
    can?(:register)
  end

  def new?
    create?
  end

  def update?
    can?(:edition)
  end

  def edit?
    update?
  end

  def destroy?
    can?(:deletion)
  end

  def can?(type, record = record_name)
    user.present? &&
      user.can_perform?(Permission.action_types[type], record)
  end

  def scope
    Pundit.policy_scope!(user_context, record)
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end

  private

  def within_scope?(id)
    scope.exists?(id)
  end

  def record_name
    case record
    when ActiveRecord::Base
      record.class.name
    when ActiveRecord::Relation
      record.klass.name
    when Class
      record.name
    end
  end
end
