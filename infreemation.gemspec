# frozen_string_literal: true

require_relative 'lib/infreemation/version'

Gem::Specification.new do |spec|
  spec.name          = 'infreemation'
  spec.version       = Infreemation::VERSION
  spec.authors       = ['mySociety']
  spec.email         = ['hello@mysociety.org']

  spec.summary       = 'Ruby library for the Infreemation API.'
  spec.description   = 'Infreemation is a eCase management software system ' \
    'built specifically to manage FOI, EIR and SAR requests.'
  spec.homepage      = 'https://github.com/mysociety/infreemation-ruby'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.0')

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added
  # into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'json', '>= 2.5.1', '< 2.10.0'
  spec.add_dependency 'rest-client', '~> 2.1.0'
end
