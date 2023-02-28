# frozen_string_literal: true

class SeedPermissionsForTeamsUsers < ActiveRecord::Migration[7.0]
  class Profile < ActiveRecord::Base
    has_and_belongs_to_many :permissions
  end

  class Permission < ActiveRecord::Base
    has_and_belongs_to_many :profiles
  end

  def up
    resource = 'TeamUser'

    Profile.reset_column_information
    Permission.reset_column_information

    actions.each do |acc, idx|
      next if Permission.where(resource: resource, action: idx).exists?

      nuevo = Permission.create name: "#{acc.to_s.titleize} #{resource.titleize}",
                                resource: resource,
                                action: idx

      puts " * created: #{nuevo.to_json}"
    end

    # Add permissions to profiles
    profiles = [
      'SuperAdmin', 'Admin'
    ]

    profiles.each do |profile|
      all_resource = Permission.where resource: resource
      profile = Profile.find_or_create_by! name: profile

      new_permissions = [all_resource].flatten.map(&:id)
      profile.permission_ids = profile.permission_ids | new_permissions

      puts " ** Permissions added to #{profile.name}: "
      puts "  * #{resource}:"
      puts "    #{Permission.find(new_permissions).map(&:name) * ', '}"
    end
  end

  private

  def actions
    {
      register: 'register',
      edition:  'edition',
      deletion: 'deletion',
      read:     'read',
      list:     'list'
    }
  end
end
