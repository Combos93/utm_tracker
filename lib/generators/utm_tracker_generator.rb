# frozen_string_literal: true

require 'rails/generators/active_record'

class UtmTrackerGenerator < ActiveRecord::Generators::Base
  desc 'Create a migration that adds utm_data into your model for UTM-tags'

  source_root File.expand_path('templates', __dir__)

  def generate_migration
    migration_template 'utm_tracker_migration.rb.erb', "db/migrate/#{migration_file_name}",
                       migration_version: migration_version
  end

  def migration_name
    "add_utm_data_to_#{name.underscore.pluralize}"
  end

  def migration_file_name
    "#{migration_name}.rb"
  end

  def migration_class_name
    migration_name.camelize
  end

  def migration_version
    "[#{ActiveRecord::Migration.current_version}]"
  end
end
