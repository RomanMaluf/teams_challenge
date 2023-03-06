# frozen_string_literal: true

class Profile < ApplicationRecord
  include Swagger::ProfileSchema

  has_and_belongs_to_many :permissions
  has_many :roles

  validates :name,
            presence: true,
            uniqueness: true

  scope :elegibles, -> (is_admin= false, names = ['SuperAdmin']) {
    names << 'Admin' unless is_admin
    where.not(name: names)
  }
end
