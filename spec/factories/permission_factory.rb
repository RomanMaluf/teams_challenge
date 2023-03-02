# frozen_string_literal: true

require 'rails_helper'

FactoryBot.define do
  factory :permission, class: 'Permission' do
      resource    { 'User' }
      action      { 'read' }
      sequence(:name)   { |n| "#{resource} #{action} ##{n} - #{Kernel.rand(9999)}" }
  end
end