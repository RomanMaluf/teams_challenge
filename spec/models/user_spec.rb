# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end

  context 'with invalid email' do
    it 'return invalud user' do
      user = User.new(email: 'Sarasa', password: '123456')

      user.save

      expect(user).to be_invalid
    end
  end

  context 'with valid values' do
    it 'return true' do
      user = build(:user)

      user.save

      expect(user).to be_valid
      expect(user.admin?).to be_falsy
    end
  end
end
