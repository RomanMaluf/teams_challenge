# frozen_string_literal: true

require 'rails_helper'

FactoryBot.factories.map(&:name).each do |factory_name|
  describe "The #{factory_name} factory" do
    it 'is valid' do
      expect(build(factory_name)).to be_valid
    end

    it 'is able to create a list' do
      expect(create_list(factory_name, 2).count).to eq(2)
    end
  end
end
