# frozen_string_literal: true

require 'rails_helper'

describe UserPolicy do
  subject { described_class }
  let(:admin_user) { User.create!(email: 'admin@example.com', password: '123123123') }
  let(:user) { User.create!(email: 'user1@example.com', password: '123123123') }
  let(:other_user) { User.create!(email: 'user2@example.com', password: '123123123') }



  permissions :update?, :edit? do
    it "denies access if user isn't itself" do
      expect(subject).not_to permit(user, other_user)
    end

    it "grants access to itself" do
      expect(subject).to permit(user, user)
    end
  end

  permissions :new?, :create? do
    it "denies access if user isnt admin" do
      expect(subject).not_to permit(user, User.new)
    end
  end

  permissions :index? do
    it "denies access if user isnt admin" do
      expect(subject).not_to permit(user, User)
    end
  end
end


