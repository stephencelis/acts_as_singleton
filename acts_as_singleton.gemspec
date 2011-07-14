Gem::Specification.new do |s|
  s.date = "2010-07-28"

  s.name = "acts_as_singleton"
  s.version = "0.0.6.beta"
  s.summary = "A lightweight singleton library for your Active Record models."
  s.description = "It just makes sense to store mutable, site-wide, admin-level settings in the database. Right? A key-value table may be more flexible, but maybe we don't want to be flexible! If you truly want that flexibility: http://github.com/stephencelis/kvc"

  s.files = ["History.rdoc", "Manifest.txt", "README.rdoc", "Rakefile", "init.rb", "lib/acts_as_singleton.rb", "test/acts_as_singleton_test.rb"]

  s.add_dependency "activerecord", "~> 3.1.0.rc4"
  s.add_development_dependency "rake"
  s.add_development_dependency "sqlite3-ruby"

  s.has_rdoc = true
  s.extra_rdoc_files = %w(History.rdoc Manifest.txt README.rdoc)
  s.rdoc_options = %w(--main README.rdoc)

  s.author = "Stephen Celis"
  s.email = "stephen@stephencelis.com"
  s.homepage = "http://github.com/stephencelis/acts_as_singleton"
end
