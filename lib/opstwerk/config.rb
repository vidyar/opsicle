require 'yaml'

module Opstwerk
  class Config
    attr_reader :environment

    def initialize(environment)
      @environment = environment.to_sym
    end

    def aws_config
      load_config('~/.fog')
    end

    def opsworks_config
      load_config('.opstwerk')
    end

    def configure_aws!
      AWS.config(aws_config)
    end

    def load_config(file)
      symbolize_keys(YAML.load_file(file))[environment] rescue {}
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
  end
end
