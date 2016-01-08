require 'net/http'

module AkamaiTools
  class Purge
    cattr_accessor :host, :user, :password, :api_url
    attr_accessor :host, :user, :password, :api_url
    self.api_url = "https://api.ccu.akamai.com/ccu/v2/queues/default"

    def self.configure
      yield self
    end

    def initialize(options = {})
      @host = options.fetch(:host, self.class.host)
      @user = options.fetch(:user, self.class.user)
      @password = options.fetch(:password, self.class.password)
      @api_url = options.fetch(:api_url, self.class.api_url)
    end

    def remove(*files)
      request body("remove", files)
    end

    def invalidate(*files)
      request body("invalidate", files)
    end

    private

    def prefix_files(files)
      files.map { |file| "#{host}/#{file}" }
    end

    def body(action, files)
      files = prefix_files(files)
      {
        type: :arl,
        action: action,
        objects: files
      }.to_json
    end

    def request(body)
      uri = URI.parse(api_url)
      request = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json'})
      request.basic_auth user, password
      request.body = body
      AkamaiTools.log :request, body
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      response = http.request(request)
      unless response.is_a?(Net::HTTPSuccess)
        raise Error.new("Purge request error: \n#{response.body}")
      end
      AkamaiTools.log :response, response.body
    end
  end
end
