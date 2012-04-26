require "rake/testtask"

desc "Default: run all tests"
task :default => :test

desc "Launch Skat"
task :launch do
  jruby "bin/skat"
end

desc "Run tests"
task :test => %w(test:units test:acceptance)
namespace :test do
  desc "Run unit tests"
  Rake::TestTask.new(:units) do |t|
    t.test_files = FileList["test/unit/*_test.rb"]
  end

  desc "Run acceptance tests"
  Rake::TestTask.new(:acceptance) do |t|
    t.test_files = FileList["test/acceptance/*_test.rb"]
  end
end
