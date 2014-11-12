Gem::Specification.new do |gem|
  gem.name          = 'kk'
  gem.version       = '0.0.1'
  gem.date          = '2014-11-05'
  gem.summary       = "Personal CLI/web diary/journaling tool"
  gem.description   = "Personal CLI/web diary/journaling tool with tagging, templates, and customizable data fields"
  gem.authors       = ["David Brady"]
  gem.email         = 'dbrady@shinybit.com'
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map {|f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(spec|test|features)/})
  gem.require_paths = ["lib"]
  gem.homepage      = 'https://github.com/dbrady/kk'
  gem.license       = 'MIT'

  gem.add_dependency "sqlite3", "~> 1.3"
  gem.add_dependency "sequel", "~> 4.16"

  gem.add_development_dependency "rspec", "~> 3.1"
  gem.add_development_dependency "guard", "~> 2.8"
  gem.add_development_dependency "guard-rspec", "~> 4.3"

end
