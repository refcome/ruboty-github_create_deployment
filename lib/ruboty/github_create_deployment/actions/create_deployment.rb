# frozen_string_literal: true

module Ruboty
  module GithubCreateDeployment
    module Actions
      class CreateDeployment < Ruboty::Github::Actions::Base
        def call
          if has_access_token?
            create
          else
            require_access_token
          end
        end

        private def create
          client.create_deployment(
            repository,
            ref,
            {
              auto_merge: false,
              environment: message[:environment],
            }.compact,
          )

          message.reply("Created!")
        rescue Octokit::Unauthorized
          message.reply("Failed in authentication (401)")
        rescue Octokit::NotFound
          message.reply("Could not find that repository")
        rescue => exception
          message.reply("Failed by #{exception.class}")
        end

        private def git_ref
          message[:git_ref]
        end

        private def repository
          git_ref.split(":").first
        end

        private def ref
          git_ref.split(":").last
        end

        private def environment
          message[:environment]
        end
      end
    end
  end
end