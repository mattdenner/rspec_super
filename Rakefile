require 'rubygems'
require 'rake'

require 'rake/rdoctask'

Rake::RDocTask.new do |rd|
	rd.rdoc_dir = 'doc'
	rd.main = 'README.rdoc'
	rd.rdoc_files.include('README.rdoc', 'lib/**/*.rb')
end

require 'rcov'
require 'spec/rake/spectask'
require 'metric_fu'

MetricFu::Configuration.run do |config|
	config.rcov.merge!(
		:rcov_opts => [
			"--include spec:lib",
			"--sort coverage", 
			"--no-html", 
			"--text-coverage",
			"--no-color",
			"--profile",
			'--exclude spec'
		],
		:test_files => [
			'spec/**/*_spec.rb'
		]
	)
end

Spec::Rake::SpecTask.new do |t|
	t.spec_files = FileList[ 'spec/**/*_spec.rb' ]
end

require 'jeweler'

Jeweler::Tasks.new do |gemspec|
	gemspec.name        = 'rspec_super'
	gemspec.summary     = 'Test methods that call super with RSpec'
	gemspec.description = 'Provides helper methods for RSpec that help you test methods that call super'
	gemspec.email       = 'matt.denner@gmail.com'
	gemspec.homepage    = 'http://github.com/mattdenner/rspec_super'
	gemspec.authors     = [ 'Matthew Denner' ]
	gemspec.has_rdoc    = 'yard'
	
	%w{ rspec metric_fu jeweler }.each { |d| gemspec.add_development_dependency(d) }
end
Jeweler::GemcutterTasks.new

