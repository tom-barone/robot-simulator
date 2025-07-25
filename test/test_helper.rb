# frozen_string_literal: true

require 'simplecov'
SimpleCov.external_at_exit = true
SimpleCov.start do
  add_filter '/test/'

  # Fail if coverage is below this value.
  # Likely unnecessary to be so strict in regular projects.
  minimum_coverage 100
end

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'robot'

require 'minitest/autorun'
