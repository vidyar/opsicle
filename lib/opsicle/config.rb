require 'yaml'
require 'aws-sdk'

module Opsicle
  class Config
    FOG_CONFIG_PATH = '~/.fog'
    OPSICLE_CONFIG_PATH = './.opsicle'


    attr_reader :environment

    def initialize(environment)
      @environment = environment.to_sym
    end

    def aws_config
      return @aws_config if @aws_config
      fog_confg = load_config(File.expand_path(FOG_CONFIG_PATH))
      @aws_config = { access_key_id: fog_confg[:aws_access_key_id], secret_access_key: fog_confg[:aws_secret_access_key] }
    end

    def opsworks_config
      @opsworks_config ||= load_config(OPSICLE_CONFIG_PATH)
    end

    def configure_aws!
      AWS.config(aws_config)
    end

    def load_config(file)
      raise MissingConfig, "Missing configuration file: #{file}  Run 'opsicle help'" unless File.exist?(file)
      env_config = symbolize_keys(YAML.load_file(file))[environment] rescue {}
      raise MissingEnvironment, "Configuration for the \'#{environment}\' environment could not be found in #{file}" unless env_config != nil

      env_config
    end

    # We want all ouf our YAML loaded keys to be symbols
    # taken from http://devblog.avdi.org/2009/07/14/recursively-symbolize-keys/
    def symbolize_keys(hash)
      hash.inject({}){|result, (key, value)|
        new_key = case key
                  when String then key.to_sym
                  else key
                  end
        new_value = case value
                    when Hash then symbolize_keys(value)
                    else value
                    end
        result[new_key] = new_value
        result
      }
    end

    MissingConfig = Class.new(StandardError)
    MissingEnvironment = Class.new(StandardError)

  end
end
