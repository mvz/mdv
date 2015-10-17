# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = 'mdv'
  s.version = '0.1.5'

  s.summary = 'Simple Markdown Viewer'
  s.description = 'Quickly view markdown files on GNOME'

  s.authors = ['Matijs van Zuijlen']
  s.email = ['matijs@matijs.net']
  s.homepage = 'http://www.github.com/mvz/mdv'

  s.executables = ['mdv']
  s.files =
    Dir['bin/*', '*.md', 'LICENSE', 'Rakefile', 'Gemfile', 'lib/**/*.rb'] &
      `git ls-files -z`.split("\0")
  s.test_files = Dir['test/**/*.rb']

  s.license = 'MIT'

  s.add_dependency('gir_ffi-gtk', ['~> 0.8.0'])
  s.add_dependency('github-markup', ['~> 1.1'])
  s.add_dependency('github-markdown', ['~> 0.6.5'])
  s.add_development_dependency('rake', ['~> 10.1'])
  s.add_development_dependency('minitest', ['~> 5.5'])
  s.add_development_dependency('atspi_app_driver', ['0.0.2'])
end
