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
