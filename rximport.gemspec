
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rximport/version"

Gem::Specification.new do |spec|
  spec.name          = "rximport"
  spec.version       = Rximport::VERSION
  spec.authors       = ["Stefan Staub"]
  spec.email         = ["stefan.staub@pta.ch"]

  spec.summary       = %q{Creek based excel parser with mapping support}
  spec.description   = %q{Flexible and configurable excel parser to read and map data from excel files}
  spec.homepage      = "https://github.com/pta-schweiz/RxImport"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency 'creek', '~> 2.4.1'
  spec.add_dependency 'concurrent-ruby'
end
