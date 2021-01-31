require_relative 'lib/json_to_csv/version'

Gem::Specification.new do |spec|
  spec.name          = "json_to_csv"
  spec.version       = JsonToCsv::VERSION
  spec.authors       = ["Youenn Priser"]
  spec.email         = ["youenn.priser@gmail.com"]

  spec.summary       = %q{This Ruby lib aims at converting JSON files composed of arrays of objects (all following the same schema) into CSV files where one line equals one object.}
  spec.homepage      = "Put your gem's website or public repo URL here."
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
