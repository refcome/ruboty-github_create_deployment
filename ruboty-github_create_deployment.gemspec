require_relative 'lib/ruboty/github_create_deployment/version'

Gem::Specification.new do |spec|
  spec.name          = "ruboty-github_create_deployment"
  spec.version       = Ruboty::GithubCreateDeployment::VERSION
  spec.authors       = ["Kouhei Suzuki"]
  spec.email         = ["kouhei.szk@gmail.com"]

  spec.summary       = "Ruboty plugin for create a GitHub deployment"
  spec.description   = "Ruboty plugin for create a GitHub deployment"
  spec.homepage      = "https://github.com/refcome/ruboty-github_create_deployment"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = spec.homepage
    spec.metadata["changelog_uri"] = spec.homepage
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "ruboty-github"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
end
