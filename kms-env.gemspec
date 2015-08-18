require File.expand_path("../lib/kms-env/version", __FILE__)

Gem::Specification.new do |spec|
  spec.name          = 'kms-env'
  spec.version       = KmsEnv::VERSION
  spec.summary       = 'Environment decryption with KMS'
  spec.description   = 'Decrypt environment variables encrypted with Amazon\'s KMS service'
  spec.author        = 'Drew Stokes'
  spec.email         = 'drew.stokes@fullscreen.com'
  spec.homepage      = 'https://github.com/Fullsceen/kms-env'
  spec.license       = 'MIT'

  spec.require_paths = ['lib']
  spec.files         = ['lib/kms-env.rb', 'lib/kms-env/railtie.rb']

  spec.add_dependency 'aws-sdk', '~> 2.1'

  spec.add_development_dependency 'bundler', '~> 1.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rake', '~> 10.0'
end
