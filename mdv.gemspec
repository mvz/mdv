# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = "mdv"
  s.version = "0.5.1"

  s.summary = "Simple Markdown Viewer"
  s.description = "Quickly view markdown files on GNOME"
  s.required_ruby_version = ">= 2.4.0"

  s.authors = ["Matijs van Zuijlen"]
  s.email = ["matijs@matijs.net"]
  s.homepage = "http://www.github.com/mvz/mdv"

  s.executables = ["mdv"]
  s.files =
    Dir["bin/*", "*.md", "LICENSE", "Rakefile", "Gemfile", "lib/**/*.rb"] &
    `git ls-files -z`.split("\0")
  s.test_files = Dir["test/**/*.rb"]

  s.license = "MIT"

  s.add_dependency("gir_ffi-gtk", ["~> 0.15.0"])
  s.add_dependency("github-markdown", ["~> 0.6.5"])
  s.add_dependency("github-markup", ["~> 3.0"])
  s.add_development_dependency("atspi_app_driver", ["~> 0.6.0"])
  s.add_development_dependency("minitest", ["~> 5.12"])
  s.add_development_dependency("rake", ["~> 13.0"])
end
