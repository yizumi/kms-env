version = File.read(File.expand_path('../VERSION', __FILE__)).strip

Gem::Specification.new do |spec|
  spec.name          = 'kms-env'
  spec.version       = version
  spec.summary       = 'Environment decryption with KMS'
  spec.description   = 'Decrypt environment variables encrypted with Amazon\'s KMS service'
  spec.author        = 'Drew Stokes'
  spec.email         = 'drew.stokes@fullscreen.com'
  spec.homepage      = 'https://github.com/fullsceen/kms-env'
  spec.license       = 'MIT'

  spec.require_paths = ['lib']
  spec.files         = ['lib/kms-env.rb']

  spec.add_dependency 'aws-sdk', '~> 2.0'
end
