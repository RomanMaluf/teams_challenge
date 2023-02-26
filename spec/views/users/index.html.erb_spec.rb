# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/index', type: :view do
  before(:each) do
    assign(:users, [
             User.create!(
               email: 'email1@example.com',
               password: 'Encrypted Password'
             ),
             User.create!(
               email: 'email2@example.com',
               password: 'Encrypted Password'
             )
           ])
  end

  it 'renders a list of users with his emails' do
    render
    cell_selector = 'tr>td'
    assert_select cell_selector, text: Regexp.new('email'.to_s), count: 2
  end
end
