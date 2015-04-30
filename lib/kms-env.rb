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

  def kms
    @kms ||= Aws::KMS::Client.new(region: ENV['AWS_REGION'] || 'us-east-1')
  end

  def ciphertext_blob_for(text)
    Base64.decode64(text)
  end

  def kms_decrypt_blob(blob)
    kms.decrypt(ciphertext_blob: blob)
  rescue Exception => e
    self.logger.error("Failed to decrypt env with error #{e.class}")
    if defined?(Honeybadger)
      Honeybadger.notify(e)
    end
  end

  def plaintext_key_for(key)
    key.gsub(kms_key_matcher, '')
  end

  def set_decrypted_env_for(key)
    # skip values that have already been decrypted
    return if ENV[plaintext_key_for(key)]
    ENV[plaintext_key_for(key)] = kms_decrypt_blob(ciphertext_blob_for(ENV[key])).first.plaintext
  end

  def kms_key_matcher
    /_KMS$/
  end

  def load
    ENV.keys.select {|k| k =~ kms_key_matcher}.each do |key|
      set_decrypted_env_for(key)
    end
  end

end

require 'kms-env/railtie' if defined?(Rails)
