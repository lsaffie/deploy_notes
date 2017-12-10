require "deploy_notes/version"
require "deploy_notes/local"
require "deploy_notes/cap"

module DeployNotes
  class Engine < ::Rails::Engine
    def self.get
      deploy_note ||= deploy_type
      deploy_note.get
    end

    private

    def self.deploy_type
      revision.blank? ? DeployNotes::Local.new : DeployNotes::Cap.new
    end

    def self.revision
      `cat #{Rails.root.to_s}/REVISION | tr -d '\n'`
    end
  end
end
