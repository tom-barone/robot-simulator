# frozen_string_literal: true

# For most projects I prefer using a Makefile or a Justfile since
# they're not dependant on ruby. But for this we may as well just
# stick to Rake.
#
# I like these files as a "oh here are the common commands I can run" reference

require 'rubocop/rake_task'
require 'yard'
require 'minitest/test_task'

desc 'Run linters'
task :lint do
  sh 'bundle exec rubocop --autocorrect-all --fail-level I'
end

desc 'Run tests'
task :test do
  Minitest::TestTask.create
  Rake::Task['test'].invoke
end

desc 'Run formatters'
task :format do
  sh 'bundle exec rubocop --fix-layout --autocorrect-all'
end

desc 'Generate documentation'
task :docs do
  YARD::Rake::YardocTask.new
  Rake::Task['yard'].invoke
end

desc 'Run type checkers'
task :types do
  sh 'bundle exec steep check'
end

desc 'Run all pre-commit checks'
task precommit: %i[format lint types test docs]

task default: :precommit
