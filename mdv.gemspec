# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "mdv"
  spec.version = "0.6.0"

  spec.authors = ["Matijs van Zuijlen"]
  spec.email = ["matijs@matijs.net"]

  spec.summary = "Simple Markdown Viewer"
  spec.description = <<~DESC
    Quickly view markdown files on GNOME
  DESC
  spec.homepage = "http://www.github.com/mvz/mdv"
  spec.license = "MIT"

  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/mvz/mdv"
  spec.metadata["changelog_uri"] = "https://github.com/mvz/mdv/blob/master/Changelog.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = File.read("Manifest.txt").split

  spec.rdoc_options = ["--main", "README.md"]
  spec.extra_rdoc_files = ["Changelog.md", "README.md"]
  spec.require_paths = ["lib"]
  spec.executables = ["mdv"]

  spec.add_runtime_dependency "gir_ffi", "~> 0.15.7"
  spec.add_runtime_dependency "gir_ffi-gtk", "~> 0.15.0"
  spec.add_runtime_dependency "github-markdown", "~> 0.6.5"
  spec.add_runtime_dependency "github-markup", ">= 3", "< 5"

  spec.add_development_dependency "atspi_app_driver", "~> 0.7.0"
  spec.add_development_dependency "minitest", "~> 5.12"
  spec.add_development_dependency "pry", "~> 0.14.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rake-manifest", "~> 0.2.0"
  spec.add_development_dependency "rubocop", "~> 1.23.0"
  spec.add_development_dependency "rubocop-minitest", "~> 0.17.0"
  spec.add_development_dependency "rubocop-packaging", "~> 0.5.0"
  spec.add_development_dependency "rubocop-performance", "~> 1.12.0"
  spec.add_development_dependency "simplecov", "~> 0.21.0"
end
