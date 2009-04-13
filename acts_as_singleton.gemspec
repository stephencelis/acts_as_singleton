# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{acts_as_singleton}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Stephen Celis"]
  s.date = %q{2009-04-13}
  s.description = %q{A lightweight singleton library for your Active Record models.  It just makes sense to store mutable, site-wide, admin-level settings in the database. Right? A key-value table may be more flexible, but maybe we don't want to be flexible!  If you truly want that flexibility: http://github.com/stephencelis/kvc}
  s.email = ["stephen@stephencelis.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "Rakefile", "init.rb", "lib/acts_as_singleton.rb", "test/acts_as_singleton_test.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/stephencelis/acts_as_singleton}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{actsassingleton}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A lightweight singleton library for your Active Record models}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<hoe>, [">= 1.12.1"])
    else
      s.add_dependency(%q<hoe>, [">= 1.12.1"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 1.12.1"])
  end
end
