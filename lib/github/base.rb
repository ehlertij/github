module Github
  class Base
    class << self
      def initialize(args={})
        # work out the default app_root
        app_root = args[:app_root] || '.'

        config_file = args[:config_file] || '/config/github.yml'
        yml_file    = app_root+config_file

        raise yml_file+" not found" unless File.exist? yml_file
        @config = YAML.load(File.open yml_file)
      end

      def base_url
        base = @config['repo_organization'] || @config['repo_user']
        "https://api.github.com/repos/#{base}/#{@config['repo']}"
      end

      def api_request(api_url, http_method='GET', params={})

        url = URI.parse(base_url + api_url)

        if http_method == 'POST'
          http = Net::HTTP.new(url.host, url.port)
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE

          request = Net::HTTP::Post.new(url.request_uri)
          request.body = params.to_json
          request.basic_auth @config['username'], @config['password']
        elsif http_method == 'DELETE'
          http = Net::HTTP.new(url.host, url.port)
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE

          request = Net::HTTP::Delete.new(url.request_uri)
          request.basic_auth @config['username'], @config['password']
        elsif http_method == 'PATCH'
          http = Net::HTTP.new(url.host, url.port)
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE

          request = Net::HTTP::Patch.new(url.request_uri)
          request.body = params.to_json
          request.basic_auth @config['username'], @config['password']
        else
          url.query = URI.encode_www_form(params)
          http = Net::HTTP.new(url.host, url.port)
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE

          request = Net::HTTP::Get.new(url.request_uri)
          request.basic_auth @config['username'], @config['password']
        end

        response = http.request(request)
        response.body
      end
    end # class
  end
end # module
