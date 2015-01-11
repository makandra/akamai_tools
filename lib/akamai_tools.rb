require "akamai_tools/version"
require "akamai_tools/purge"
require "akamai_tools/upload"

module AkamaiTools
  mattr_accessor :logging
  mattr_writer :logger
  self.logging = true

  def self.log(type, message = nil)
    return unless self.logging

    self.logger.info "AkamaiTools #{type}:\n#{message}\n"
  end

  def self.logger
    @@logger ||= AkamaiTools::Logger.new
  end

  class Logger
    def info(message)
      puts message
    end
  end
end

