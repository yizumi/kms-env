# kms-env
Decrypt environment variables encrypted with Amazon's KMS service.

# Usage
This gem decrypts environment variables with keys that end in `_KMS` and
assigns them to a key of the same name with the KMS suffix removed.

For example, the following environment variable:

```shell
MY_ENCRYPTED_VALUE_KMS="b2hhaQo="
```

Will generate a `MY_ENCRYPTED_VALUE` key in the `ENV` variable that contains
the plaintext value of the original key.

If you need to manually trigger environment parsing (to handle variables set
by initializers for example), you can call the idempotent load method:

```ruby
KmsEnv::load
```

# Installation
Add this line to the top of your Gemfile:

```ruby
gem 'kms-env', '~> 1.0'
```

And then execute:

```shell
$ bundle
```

# Configuration
This gem requires IAM access to Amazon's KMS service. Credentials can be
safely provided by either utilizing [IAM Roles](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/iam-roles-for-amazon-ec2.html)
or by setting your access credentials in the environment configuration:

```shell
AWS_ACCESS_KEY_ID=<your_key_id>
AWS_SECRET_ACCESS_KEY=<your_secret_key>
AWS_REGION=us-east-1
```
