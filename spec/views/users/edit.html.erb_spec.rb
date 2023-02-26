# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/edit', type: :view do
  let(:user) do
    User.create!(
      email: 'example@hotmail.com',
      name: 'MyString',
      password: 'MyString'
    )
  end

  before(:each) do
    assign(:user, user)
  end

  it 'renders the edit user form' do
    enable_pundit(view, user)
    render

    assert_select 'form[action=?][method=?]', user_path(user), 'post' do
      assert_select 'input[name=?]', 'user[name]'
      assert_select 'input[name=?]', 'user[english_level]'
      assert_select 'input[name=?]', 'user[cv_link]'
      assert_select 'input[name=?]', 'user[password]'
      assert_select 'input[name=?]', 'user[password_confirmation]'
      assert_select 'textarea[name=?]', 'user[technical_knowledge]'
    end
  end
end
