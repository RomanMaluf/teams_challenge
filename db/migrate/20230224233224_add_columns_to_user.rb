class AddColumnsToUser < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.string :name
      t.string :english_level
      t.text   :technical_knowledge
      t.string :cv_link
    end
  end
end
