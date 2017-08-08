require_relative '../project'

module Supercop
  module Actions
    class CreateFile
      require 'fileutils'

      def initialize(args)
        @filename = args.fetch(:filename, 'supercop.yml')
        @destination = args.fetch(:destination)
        @options = args.fetch(:options, force: false)
        @source = args.fetch(:source, 'supercop.yml.temp')
        @project = args.fetch(:project, Project)
      end

      def perform
        return "There is no destination #{destination}" if invalid_destination?

        FileUtils.copy(source_file, destination_file)

        "file #{destination_file} created"
      rescue => e
        "Could not create file. #{e.message}"
      end

      private

      attr_reader :filename, :destination, :source, :project

      def invalid_destination?
        destination.empty? || !Dir.exist?(destination)
      end

      def source_file
        project.config_files(source)
      end

      def destination_file
        File.join(destination, filename)
      end
    end
  end
end
