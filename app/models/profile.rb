# frozen_string_literal: true

class Profile < ApplicationRecord
  has_and_belongs_to_many :permissions
  has_many :roles

  validates :name,
            presence: true,
            uniqueness: true
end
