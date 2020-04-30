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
              environment: environment,
            }.compact,
          )

          message.reply("Created!")
        rescue Octokit::Unauthorized
          message.reply("Failed in authentication (401)")
        rescue Octokit::NotFound
          message.reply("Could not find that repository")
        rescue => exception
          Ruboty.logger.debug("repository: #{repository}, ref: #{ref}, environment: #{environment}")
          message.reply("Failed by #{exception.class}")
        end

        private def environment
          message[:environment]
        end

        private def repository
          message[:repo]
        end

        private def ref
          message[:ref]
        end
      end
    end
  end
end
