require "akamai_tools/version"
require "akamai_tools/purge"
require "akamai_tools/upload"

module AkamaiTools
  mattr_accessor :logging
  self.logging = true

  def self.log(type, message = nil)
    return unless self.logging

    puts "AkamaiTools #{type}:\n#{message}\n"
  end
end

