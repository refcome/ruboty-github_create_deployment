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
          Ruboty.logger.debug("repo: #{repository}")
          Ruboty.logger.debug("ref: #{ref}")
          Ruboty.logger.debug("environment: #{environment}")

          client.create_deployment(
            repository,
            ref,
            {
              auto_merge: false,
              required_contexts: [], # @note skip checking statuses
              environment: environment,
            }.compact,
          )

          message.reply("Created #{deployments_url}")
        rescue Octokit::Unauthorized
          message.reply("Failed in authentication (401)")
        rescue Octokit::NotFound
          message.reply("Could not find that repository")
        rescue => exception
          message.reply("Failed by #{exception.class}")
        end

        private def deployments_url
          "https://github.com/#{repository}/deployments"
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
