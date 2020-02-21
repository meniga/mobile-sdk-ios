
module Fastlane
    module Actions

        class AddGitRemoteAction < Action

            def self.run(options)
                remote = options[:remote]
                path = options[:path]
                cmd = ["git remote add #{remote.shellescape} #{path.shellescape}"]
                UI.message("Adding remote #{remote} '#{path}'' 🎯.")
                Actions.sh(cmd.join(' '))
            end

            def self.description
                "This will add a remote repository"
            end

            def self.details
                [
                    "This will automatically add a remote repository, where:",
                    "- `remote` is the remote name",
                    "- `path` is the remote path (URL or SSH)",
                ].join("\n")
            end

            def self.available_options
                [
                    FastlaneCore::ConfigItem.new(key: :remote,
                                                 env_name: "FL_ADD_GIT_REMOTE_REMOTE",
                                                 description: "Remote name",
                                                 optional: false),

                    FastlaneCore::ConfigItem.new(key: :path,
                                                 env_name: "FL_ADD_GIT_REMOTE_PATH",
                                                 description: "Path to repository. URL or SSH",
                                                 optional: false)
                ]
            end

            def self.example_code
                [
                    'add_git_remote(remote: "origin", path: "https://github.com/meniga/mobile-sdk-ios")'
                ]
            end

            def self.category
                :source_control
            end

            def self.is_supported?(platform)
                true
            end
        end
    end
end
