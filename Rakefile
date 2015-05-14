require 'rake/clean'
require 'bundler/gem_tasks'
require 'rake/testtask'

namespace :test do
  Rake::TestTask.new(:end_to_end) do |t|
    t.libs = ['lib']
    t.test_files = FileList['test/end_to_end/*_test.rb']
    t.warning = true
  end

  task all: [:end_to_end]
end

task test: 'test:all'

task default: 'test'
