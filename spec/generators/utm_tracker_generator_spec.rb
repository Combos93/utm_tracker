# frozen_string_literal: true

require 'spec_helper'
require 'rails/generators'
require 'rails/generators/migration'
require 'generators/utm_tracker_generator'
require 'timecop'

RSpec.describe UtmTrackerGenerator do
  subject { UtmTrackerGenerator }

  describe :next_migration_number do
    it 'next migration' do
      Timecop.freeze('2016-12-03 22:15:26 -0800') do
        if ActiveRecord.version >= Gem::Version.new('7.0')
          expect(ActiveRecord).to receive(:timestamped_migrations) { true }
        else
          expect(ActiveRecord::Base).to receive(:timestamped_migrations) { true }
        end
        expect(subject.next_migration_number(1).to_s).to eq('20161204061526')
      end
    end
  end

  describe :migration_base_class_name do
    subject { generator.send(:migration_name) }

    let(:table) { 'users' }
    let(:generator) { UtmTrackerGenerator.new([table]) }

    it 'returns the correct base class name' do
      is_expected.to eq("add_utm_data_to_#{table}")
    end
  end

  describe 'when create a migration' do
    after do
      FileUtils.rmtree('db') if Dir.exist?('db')
    end

    it 'be successful' do
      Timecop.freeze('2016-12-03 22:15:26 -0800') do
        table = 'users'
        UtmTrackerGenerator.new([table]).generate_migration

        target_migration = Dir.entries(File.expand_path('../../db/migrate', __dir__))
                              .select { |file| file.end_with?('rb') }.first

        expect(target_migration).to eq '20161204061526_add_utm_data_to_users.rb'
      end
    end
  end
end
