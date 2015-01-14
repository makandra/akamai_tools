module AkamaiTools
  class Upload
    cattr_accessor :host, :user, :connection_options, :source_root, :destination_root
    attr_accessor :host, :user, :connection_options, :source_root, :destination_root, :sftp
    self.connection_options = {}

    def self.configure
      yield self
    end

    def initialize(options = {})
      @host = options.fetch(:host, self.class.host)
      @user = options.fetch(:user, self.class.user)
      @connection_options = options.fetch(:connection_options, self.class.connection_options)
      @source_root = options.fetch(:source_root, self.class.source_root)
      @destination_root = options.fetch(:destination_root, self.class.destination_root)
    end

    def session(&block)
      AkamaiTools.log :session_start

      Net::SFTP.start(host, user, connection_options) do |sftp|
        begin
          self.sftp = sftp
          block.call self
        ensure
          self.sftp = nil
        end
      end

      AkamaiTools.log :session_end
    end

    def upload(file)
      source      = "#{source_root}/#{file}"
      destination = "#{destination_root}/#{file}"
      message = "Source: #{source}\nDestination: #{destination}"
      AkamaiTools.log :upload, file
      sftp.upload!(source, destination)
    end
  end
end
