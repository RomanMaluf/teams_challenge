# frozen_string_literal: true

FactoryBot.define do
  factory :customer_account, class: 'CustomerAccount' do
    name           { FFaker::Name.unique.name }
    customer       { FFaker::Name.unique.name }
    manager        { FFaker::Name.unique.name }
    team           { association(:team, customer_account: self.instance) }
  end
end
