# frozen_string_literal: true

require 'rails_helper'

describe UserPolicy, type: :policy do
  subject { described_class }
  let(:admin_user) { create(:user, :admin) }
  let(:super_admin) { create(:user, :super_admin) }
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe 'Scope' do
    context 'common user' do
      let(:scope) { Pundit.policy_scope!(user, User) }
      it 'grants access to show itself' do
        expect(scope.to_a).to match_array([user])
      end
      it 'denies access to other users' do
        create_list(:user, 3)
        expect(scope.to_a).to match_array([user])
      end
    end
    context 'admin user' do
      let(:scope) { Pundit.policy_scope!(admin_user, User) }
      it 'grants access to all the common users and itself' do
        expect(scope.to_a).to match_array(User.not_admins.or(User.where(id: admin_user.id)).to_a)
      end
      it 'denies access to other admin users' do
        create(:user, :admin)
        expect(scope.to_a).not_to match_array(User.all.to_a)
      end
    end
    context 'super admin user' do
      let(:scope) { Pundit.policy_scope!(create(:user, :super_admin), User) }
      it 'grants access to all the users including admins' do
        expect(scope.to_a).to match_array(User.all.to_a)
      end
    end
  end

  permissions :show? do
    it 'denies access if user isnt itself' do
      expect(subject).not_to permit(user, other_user)
    end

    it 'grants access to itself' do
      expect(subject).to permit(user, user)
    end
  end

  permissions :update?, :edit? do
    it 'denies access if user isnt itself' do
      expect(subject).not_to permit(user, other_user)
    end

    it 'grants access to itself' do
      expect(subject).to permit(user, user)
    end
  end

  permissions :new?, :create? do
    it 'denies access if user isnt admin' do
      expect(subject).not_to permit(user, User.new)
    end

    it 'grant access if user is admin' do
      expect(subject).to permit(admin_user, User.create)
    end
  end

  permissions :index? do
    it 'denies access if user isnt admin' do
      expect(subject).not_to permit(user, User)
    end

    it 'grant access if user is admin' do
      expect(subject).to permit(admin_user, User)
    end
  end

  permissions :destroy? do
    it 'denies access to all user to destroy itself' do
      expect(subject).not_to permit(user, user.destroy)
      expect(subject).not_to permit(admin_user, admin_user.destroy)
      expect(subject).not_to permit(super_admin, super_admin.destroy)
    end

    context 'common user' do
      it 'denies access to destroy users' do
        expect(subject).not_to permit(user, user.destroy)
      end
    end

    context 'admin' do
      it 'grant access to destroy other common users' do
        expect(subject).not_to permit(admin_user, user.destroy)
      end
      it 'denies access to destroy other admin users' do
        expect(subject).not_to permit(admin_user, create(:user, :admin).destroy)
      end
    end

    context 'super admin' do
      it 'grant access to destroy other common users' do
        expect(subject).not_to permit(super_admin, user.destroy)
      end
      it 'grant access to destroy other admin users' do
        expect(subject).not_to permit(super_admin, admin_user.destroy)
      end
    end
  end

  permissions :roles? do
    it 'grant access to super_admin' do
      expect(subject).to permit(super_admin, Role.new)
    end
  end
end
