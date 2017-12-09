class DeployNotes::Local
  def branch_name
    `git rev-parse --abbrev-ref HEAD`
  end

  def commit_info
    `git log -n1 --pretty=format::%ae:%s:%cr`
  end
end
