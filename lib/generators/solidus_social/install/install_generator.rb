# frozen_string_literal: true

module SolidusSocial
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.dirname(__FILE__) + "/templates"

      class_option :auto_run_migrations, type: :boolean, default: false

      def add_stylesheets
        inject_into_file 'vendor/assets/stylesheets/spree/frontend/all.css', " *= require spree/frontend/solidus_social\n", before: %r(\*/), verbose: true
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=solidus_social'
      end

      def copy_initializer
        template "config/initializers/solidus_social.rb"
      end

      def add_tasks
        run 'bundle exec rake solidus_social:load_permissions'
      end

      def run_migrations
        run_migrations = options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask('Would you like to run the migrations now? [Y/n]'))
        if run_migrations
          run 'bundle exec rake db:migrate'
        else
          puts 'Skipping rake db:migrate, don\'t forget to run it!'
        end
      end
    end
  end
end
