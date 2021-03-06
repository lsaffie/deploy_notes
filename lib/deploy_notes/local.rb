module DeployNotes
  # Class for local deployments
  class Local
    def get
      "[#{branch_name}] - [#{commit_info}]"
    end

    private

    def branch_name
      `git rev-parse --abbrev-ref HEAD`
    end

    def commit_info
      `git log -n1 --pretty=format:[%ae:%s][%cr][%h]`
    end
  end
end
