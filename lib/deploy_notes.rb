require "deploy_notes/version"
require "deploy_notes/local"
require "deploy_notes/cap"

class DeployNotes
  def initialize
    @deploy_note = deploy_type
  end

  def get
    @deploy_note.branch_name + ":" + @deploy_note.commit_info
  end

  private

  def deploy_type
    revision.blank? ? DeployNotes::Local.new : DeployNotes::Cap.new
  end

  def revision
    `cat #{Rails.root.to_s}/REVISION | tr -d '\n'`
  end
end
