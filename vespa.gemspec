require 'rake'

Gem::Specification.new do |s|
  s.name = %q{krl}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Philip Dodds"]
  s.date = %q{2011-11-1}
  s.email = %q{mjf@kynetx.com}
  s.extra_rdoc_files = ["LICENSE"]
  s.homepage = %q{http://github.com/pdodds/vespa}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.bindir = 'bin'
  s.executables = ['vespa']
  s.rubygems_version = %q{1.3.8}
  s.has_rdoc = false
  s.summary = %q{Use the HornetQ Restful API from Ruby}

  s.description = <<-EOF
    Use the HornetQ Restful API from Ruby
  EOF

  s.files = FileList['lib/**/*.rb', 'bin/**/**', "LICENSE"].to_a
  
end
