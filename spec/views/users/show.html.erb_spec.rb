# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/show', type: :view do
  let(:user) do
    User.create!(
      email: 'example@arkusnexus.com',
      password: 'Encrypted Password',
      name: 'Jhon Dude',
      english_level: 'B1',
      technical_knowledge: 'Scrum Master',
      cv_link: 'some link'
    )
  end

  before(:each) do
    assign(:user, user)
  end

  it 'renders attributes in <td>' do
    enable_pundit(view, user)
    render

    cell_selector = 'tr>td'
    excepted_attributes = %w[id created_at updated_at remember_created_at encrypted_password]

    user.attributes.except(*excepted_attributes).each do |k, v|
      assert_select 'label[for=?]', "user_#{k}", count: 1
      assert_select cell_selector,  text: v,     count: 1
    end
  end
end
