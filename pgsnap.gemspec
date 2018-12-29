lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pgsnap/version'

Gem::Specification.new do |spec|
  spec.name          = 'pgsnap'
  spec.version       = Pgsnap::VERSION
  spec.authors       = ['David Chin']
  spec.email         = ['dlcmhd@me.com']

  spec.summary       = %q{Pgsnap makes working with PostgreSQL queries infinitely more pleasant.}
  spec.description   = %q{Construct composable, structured, PostgreSQL queries in plain Ruby.}
  spec.homepage      = 'https://github.com/dlcmh/pgsnap'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.0.0'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split('\x0').reject do |f|
      f.match(%r{^(test|spec|features|bin)/}) ||
        f.match(%r{^(Guardfile|Rakefile|Gemfile|examples)}) ||
        f.match(%r{(examples|gemspec)})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'pg', '~> 1.1'
end
