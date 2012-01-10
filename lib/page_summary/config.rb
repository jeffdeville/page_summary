module PageSummary
  module Config
    extend self
    #
    ## Get the name of the environment that we are running under. This first
    ## looks for Rails, then Sinatra, then a RACK_ENV environment variable,
    ## and if none of those are found returns "development".
    ##
    ## @example Get the env name.
    ##   Environment.env_name
    ##
    ## @return [ String ] The name of the current environment.
    #def env_name
    #  return Rails.env if defined?(Rails)
    #  return Sinatra::Base.environment.to_s if defined?(Sinatra)
    #  ENV["RACK_ENV"] || raise(Errors::NoEnvironment.new)
    #end
    #
    ## Load the yaml from the provided path and return the settings for the
    ## current environment.
    ##
    ## @example Load the yaml.
    ##   Environment.load_yaml("/work/mongoid.yml")
    ##
    ## @param [ String ] path The location of the file.
    ##
    ## @return [ Hash ] The settings.
    #def load_yaml(path)
    #  YAML.load(ERB.new(File.new(path).read).result)[env_name]
    #end

    HOST = ENV['PAGESUMMARY_HOST'] || "0.0.0.0"
    PORT = ENV['PAGESUMMARY_PORT'] || "8080"

  end
end