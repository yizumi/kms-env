require 'spec_helper'
require 'aws-sdk'

describe KmsEnv do
  describe '#load' do
    before do
      kms_response = double("first kms decrypted",plaintext:'decrypted_text')
      Aws::KMS::Client.any_instance.stub(:decrypt).and_return(kms_response)
    end
    it 'sets the ENV variable' do
      ENV['MY_VALUE_KMS'] = "c29tZSBjaXBoZXJ0ZXh0\n"
      KmsEnv.load
      expect(ENV.fetch('MY_VALUE')).to eq('decrypted_text')
    end

    it 'sets the ENV variable dynamically' do
      ENV['ARBITRARY_VALUE_KMS'] = "c29tZSBjaXBoZXJ0ZXh0\n"
      KmsEnv.load
      expect(ENV.fetch('ARBITRARY_VALUE')).to eq('decrypted_text')
    end
  end
end
