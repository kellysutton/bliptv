# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{bliptv}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Kelly Sutton"]
  s.date = %q{2009-06-05}
  s.description = %q{A Ruby library from Blip.tv}
  s.email = %q{michael.k.sutton@gmail.com}
  s.extra_rdoc_files = ["lib/bliptv/api_spec.rb", "lib/bliptv/base.rb", "lib/bliptv/multipart_params.rb", "lib/bliptv/request.rb", "lib/bliptv/video.rb", "lib/bliptv.rb", "lib/ext/array.rb", "lib/ext/hash.rb", "lib/ext/open_struct.rb", "README.rdoc"]
  s.files = ["lib/bliptv/api_spec.rb", "lib/bliptv/base.rb", "lib/bliptv/multipart_params.rb", "lib/bliptv/request.rb", "lib/bliptv/video.rb", "lib/bliptv.rb", "lib/ext/array.rb", "lib/ext/hash.rb", "lib/ext/open_struct.rb", "License.txt", "Manifest", "Rakefile", "README.rdoc", "test/test_base.rb", "test/test_suite.rb", "test/test_video.rb", "bliptv.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/kellysutton/bliptv}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Bliptv", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{bliptv}
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{A Ruby library from Blip.tv}
  s.test_files = ["test/test_base.rb", "test/test_suite.rb", "test/test_video.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
