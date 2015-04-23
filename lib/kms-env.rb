require 'base64'
require 'aws-sdk'

module KmsEnv

  module_function

  def logger
    defined?(Rails) ? Rails.logger : Logger.new(STDERR)
  end

  ###
  # Load decrypted environment variables
  ###
  def load
    matcher = /_KMS$/
    kms = Aws::KMS::Client.new(region: 'us-east-1')

    ENV.keys.each do |key|
      # skip keys not ending in _KMS
      next unless key =~ matcher

      # skip values that have already been decrypted
      plaintext_key = key.gsub(matcher, '')
      next if ENV[plaintext_key]

      ciphertext_blob = Base64.decode64(ENV[key])
      begin
        # binding.pry
        resp = kms.decrypt(ciphertext_blob: ciphertext_blob)
        ENV[plaintext_key] = resp.first.plaintext
      rescue Exception => e
        self.logger.error("Failed to decrypt #{key} with error #{e.class}")
      end
    end
  end

end

require 'kms-env/railtie' if defined?(Rails)
