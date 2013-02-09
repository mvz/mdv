# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "mdv"
  s.version = "0.1.1"

  s.summary = "Simple Markdown Viewer"
  s.description = "Quickly view markdown files on GNOME"

  s.authors = ["Matijs van Zuijlen"]
  s.email = ["matijs@matijs.net"]
  s.homepage = "http://www.github.com/mvz/mdv"

  s.executables = ['mdv']
  s.files = Dir['{lib,test}/**/*.rb', "bin/*", "*.md", "LICENSE"]
  s.test_files = Dir['test/**/*.rb']

  s.add_dependency('gir_ffi-gtk', ["~> 0.5.0"])
  s.add_dependency('github-markup', ["~> 0.7.2"])
end
