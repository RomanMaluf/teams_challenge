# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/index', type: :view do
  before(:each) do
    @search = User.ransack # To avoid No Ransack::Search object was provided to search_form_for!
  end

  context 'with admin user logged in' do
    let(:admin_user) { create(:user, :admin)}

    before(:each) do
      assign(:users, create_list(:user,2))
    end

    it 'renders a list of users with his emails' do
      render
      cell_selector = 'tr>td'
      assert_select cell_selector, text: Regexp.new('@'.to_s), count: 2
    end
  end

  context 'with common user logged in' do
    let(:common_user) { create(:user) }

    before(:each) do
      assign(:users, create_list(:user,2))
    end

    it 'renders a not authorized user page' do
      render
      cell_selector = 'tr>td'
      assert_select cell_selector, text: Regexp.new('@'.to_s), count: 2
    end
  end
end
