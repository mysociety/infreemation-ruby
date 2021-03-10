# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'infreemation/version'

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

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the
  # "allowed_push_host" to allow pushing to a single host or delete this section
  # to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'json', '~> 2.3'
  spec.add_dependency 'rest-client', '~> 2.1.0'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.81.0'
  spec.add_development_dependency 'webmock', '~> 3.3.0'
end
