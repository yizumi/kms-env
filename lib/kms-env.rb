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
    @kms ||= Aws::KMS::Client.new(region: 'us-east-1')
  end
  
  def ciphertext_blob_for(text)
    Base64.decode64(text)
  end
  
  def kms_decrypt_text(text)
    kms.decrypt(ciphertext_blob: text)
  rescue Exception => e
    self.logger.error("Failed to decrypt #{key} with error #{e.class}")
  end
  
  def plaintext_key_for(key)
    key.gsub(matcher, '')
  end
  
  def set_decrypted_env_for(key)
    # skip values that have already been decrypted
    return if ENV[plaintext_key_for(key)]
    ENV[plaintext_key_for(key)] = kms_decrypt_text(ciphertext_blob_for(ENV[key])).first.plaintext    
  end
  
  def matcher
    /_KMS$/
  end
  
  def load
    ENV.keys.select {|k| k =~ matcher}.each do |key|
      set_decrypted_env_for(key)
    end
  end

end

require 'kms-env/railtie' if defined?(Rails)
