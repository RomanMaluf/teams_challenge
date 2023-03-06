class AddUserApiKey < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.string :api_key, limit: 48
    end
  end
end
