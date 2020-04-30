# frozen_string_literal: true

module Ruboty
  module Handlers
    class GithubCreateDeployment < Base
      on(
        /create deployment of (?<repo>\S+):(?<ref>\S+)( to (?<environment>\S+))?\z/,
        name: "create_deployment",
        description: "Generate deployment on GitHub",
      )

      def create_deployment(message)
        Ruboty::GithubCreateDeployment::Actions::CreateDeployment.new(message).call
      end
    end
  end
end
