require 'rspec/core/rake_task'

begin
RSpec::Core::RakeTask.new('spec')
desc "Run tests"
task :default => :spec
end

=begin  remember this is for Test::Unit testing framework
require 'rake/testtask'	
Rake::TestTask.new do |t|
	t.libs << 'test'
end

desc "Run tests"
task :default => :test 
=end