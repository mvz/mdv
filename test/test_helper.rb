# frozen_string_literal: true

require "simplecov"
SimpleCov.start do
  add_group "Main", "lib"
  add_group "Tests", "test"
  enable_coverage :branch
end

require "minitest/autorun"
require "minitest/focus"
