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

class DeployNotes::Local
  def branch_name
    `git rev-parse --abbrev-ref HEAD`
  end

  def commit_info
    `git log -n1 --pretty=format::%ae:%s:%cr`
  end
end

class DeployNotes::Cap
  def branch_name
    `tail -1 #{current}/../../revisions.log`
  end

  def commit_info
    `git --git-dir=#{repo} --work-tree #{current}
     log #{revision} -n1 --pretty=format::%ae:%s:%cr`
  end

  private

  def current
    Rails.root.to_s
  end

  def repo
    "#{current}/../../repo"
  end

  def revision
    `cat #{current}/REVISION | tr -d '\n'`
  end
end
