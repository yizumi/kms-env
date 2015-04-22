# kms-env
Decrypt environment variables encrypted with Amazon's KMS service

# Examples
```ruby
# config/initializers/kms-env.rb
require 'kms-env'

# given ENV['MY_VALUE_KMS'] = <ciphertext>
KmsEnv.load # => ENV['MY_VALUE'] = <plaintext>
```

# Install
To include this gem in a bundled project, add the following to your Gemfile:

```ruby
gem 'kms-env', '~> 1.0'
```
