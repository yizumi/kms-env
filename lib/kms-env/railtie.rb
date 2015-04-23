module KmsEnv
  class Railtie < Rails::Railtie
    config.before_configuration { load }

    def load
      KmsEnv.load
    end

    def self.load
      instance.load
    end
  end
end
