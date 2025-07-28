# frozen_string_literal: true

# For most projects I prefer using a Makefile or a Justfile since
# they're not dependant on ruby. But for this we may as well just
# stick to Rake.
#
# I like these files as a "oh here are the common commands I can run" reference

require 'rubocop/rake_task'
require 'minitest/test_task'

CHECKS = %i[format lint types test docs].freeze
task default: :precommit

desc 'Run linters'
task :lint do
  sh 'bundle exec rubocop --autocorrect-all --fail-level I'
end

desc 'Run tests'
task :test do
  Minitest::TestTask.create
  # Run like `rake test A='--verbose` to pass additional arguments
  Rake::Task['test'].invoke
end

desc 'Run formatters'
task :format do
  sh 'bundle exec rubocop --fix-layout --autocorrect-all'
end

desc 'Generate documentation'
task :docs do
  sh 'bundle exec rdoc lib README.md --main README.md --output doc'
end

desc 'Run type checkers'
task :types do
  sh 'bundle exec steep check'
end

desc 'Make sure checks pass in Docker, for both x86 and ARM'
task :docker do
  %w[linux/amd64 linux/arm64].each do |platform|
    tag = "robot-simulator:#{platform}".tr('/', '-')
    # Quiet build to avoid stuffing too much output into Claude Code
    sh "docker build --quiet --platform #{platform} -t #{tag} ."
    sh "docker run --rm #{tag} rake #{CHECKS.join(' ')}"
  end
end

desc 'Run all pre-commit checks'
task precommit: CHECKS + [:docker]

desc 'Clean up generated files'
task :clean do
  sh 'rm -rf doc'
  sh 'rm -rf coverage'
end
