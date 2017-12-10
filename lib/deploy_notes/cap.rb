module DeployNotes
  class Cap
    def get
      branch_name + deploy_time + commit_info
    end

    def branch_name
      `tail -1 #{current}/../../revisions.log`
    end

    def deploy_time
      deploy_time = `stat -c '%y' #{current}/REVISION`
      deploy_time.to_time.to_s(:db)
    end

    def commit_info
      `git --git-dir=#{repo} --work-tree #{current} log #{revision} -n1 --pretty=format::%ae:%s`
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
end
