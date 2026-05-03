# frozen_string_literal: true

require_relative "lib/mdv/version"

Gem::Specification.new do |spec|
  spec.name = "mdv"
  spec.version = MDV::VERSION
  spec.authors = ["Matijs van Zuijlen"]
  spec.email = ["matijs@matijs.net"]

  spec.summary = "Simple Markdown Viewer"
  spec.description = <<~DESC
    Quickly view markdown files on GNOME
  DESC
  spec.homepage = "http://www.github.com/mvz/mdv"

  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/mvz/mdv"
  spec.metadata["changelog_uri"] = "https://github.com/mvz/mdv/blob/master/Changelog.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = File.read("Manifest.txt").split
  spec.bindir = "bin"
  spec.executables = ["mdv"]
  spec.require_paths = ["lib"]

  spec.rdoc_options = ["--main", "README.md"]
  spec.extra_rdoc_files = ["Changelog.md", "README.md"]

  spec.add_dependency "commonmarker", "~> 2.0"
  spec.add_dependency "gir_ffi", "~> 0.19.0"
  spec.add_dependency "gir_ffi-gtk", "~> 0.19.0"
end
