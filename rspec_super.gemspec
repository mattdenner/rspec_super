Gem::Specification.new do |s|
  s.rubygems_version          = %q{1.3.6}
  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6")
  s.specification_version     = 3

  s.name    = %q{rspec_super}
  s.version = '0.1.1'
  
  s.add_development_dependency(%q<rspec>, [">= 1.3.0"])
  s.add_development_dependency(%q<yard>, [">= 0.5.4"])
  s.add_dependency(%q<rspec>, [">= 1.3.0"])

  s.authors     = ["Matthew Denner"]
  s.date        = %q{2010-06-19}
  s.summary     = %q{Test methods that call super with RSpec}
  s.description = %q{Provides helper methods for RSpec that help you test methods that call super}
  s.email       = %q{matt.denner@gmail.com}
  s.homepage    = %q{http://github.com/mattdenner/rspec_super}

  s.has_rdoc         = %q{yard}
  s.rdoc_options     = ["--charset=UTF-8"]
  s.extra_rdoc_files = [ "README.markdown" ]

  s.require_paths = ["lib"]
  s.files = [
     "README.markdown",
     "Rakefile",
     "lib/rspec_super.rb",
     "spec/rspec_super/direct_derivative_spec.rb",
     "spec/rspec_super/non_direct_derivative_spec.rb",
     "spec/rspec_super/passing_arguments_spec.rb",
     "spec/rspec_super/yielding_to_block_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.test_files = [
    "spec/spec_helper.rb",
     "spec/rspec_super/direct_derivative_spec.rb",
     "spec/rspec_super/non_direct_derivative_spec.rb",
     "spec/rspec_super/passing_arguments_spec.rb",
     "spec/rspec_super/yielding_to_block_spec.rb"
  ]
end

