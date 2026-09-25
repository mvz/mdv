# frozen_string_literal: true

require "simplecov"
SimpleCov.start do
  enable_coverage :branch
end

require "minitest/autorun"
require "minitest/focus"
