# frozen_string_literal: true

class CreateRolAndPermissionsSchema < ActiveRecord::Migration[7.0]
  def change
    create_table :permissions do |t|
      t.string :name
      t.string :resource
      t.string :action
  
      t.timestamps
    end

    create_table :profiles do |t|
      t.string :name

      t.timestamps
    end

    create_table :permissions_profiles, id: false do |t|
      t.belongs_to :profile
      t.belongs_to :permission

      t.timestamps
    end
  
    create_table :roles do |t|
      t.belongs_to :profile
      t.belongs_to :user

      t.timestamps
    end

    add_index :roles,       [:user_id, :profile_id], unique: true
    add_index :permissions, [:name], unique: true
    add_index :profiles,    [:name], unique: true
    add_index :permissions_profiles, [:profile_id, :permission_id], unique: true, name: 'tn_perfil_permiso'
  end
end