# frozen_string_literal: true

require 'rails_helper'

describe CustomerAccountPolicy, type: :policy do
  subject { described_class }
  let(:admin_user) { create(:user, :admin) }
  let(:super_admin) { create(:user, :super_admin) }
  let(:user) { create(:user) }
  let(:customer_accounts) { create_list(:customer_account, 2) }

  describe 'Scope' do
    context 'common user' do
      let(:scope) { Pundit.policy_scope!(user, CustomerAccount) }
      it 'denies access to all customers account' do
        customer_accounts.map(&:reload)
        expect(scope.to_a).to match_array([])
      end
    end
    context 'user#admin?' do
      let(:scope) { Pundit.policy_scope!(super_admin, CustomerAccount) }

      it 'grants access to all customers account' do
        customer_accounts.map(&:reload)
        expect(scope.to_a).to match_array(customer_accounts)
      end
    end
    context 'user#can_perform' do
      it 'grants access to all customers account' do
        user_with_role = create(:user, :with_specific_role, specific_role: 'List Customer Account')
        scope = Pundit.policy_scope!(user_with_role, CustomerAccount)
        customer_accounts.map(&:reload)
        expect(scope.to_a).to match_array(customer_accounts)
      end
    end
  end
end
