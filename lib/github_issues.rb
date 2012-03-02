# require "github_issues/version"
require 'uri'
require 'net/https'
require 'json'
require 'yaml'

module GithubIssues
  class << self

    def configure(args={})    
      # work out the default app_root
      app_root = args[:app_root] || '.'
      
      config_file = args[:config_file] || '/config/github_issues.yml'
      yml_file    = app_root+config_file
      
      raise yml_file+" not found" unless File.exist? yml_file
      @config = YAML.load(File.open yml_file)
    end

    def base_url
      "https://api.github.com/repos/#{@config['repo_user']}/#{@config['repo']}"
    end

    def get(id)
      JSON.parse(api_request("#{base_url}/issues/#{id}", 'GET'))
    end

    def list(options={})
      JSON.parse(api_request("#{base_url}/issues", 'GET', options))
    end

    def create(options={})
      JSON.parse(api_request("#{base_url}/issues", 'POST', options))
    end

    def update(id, options={})
      JSON.parse(api_request("#{base_url}/issues/#{id}", 'PATCH', options))
    end

    def create_label(options={})
      JSON.parse(api_request("#{base_url}/labels", 'POST', options))
    end

    def api_request(api_url, http_method='GET', params={})

      url = URI.parse(api_url)

      if http_method == 'POST'
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Post.new(url.request_uri)
        request.body = params.to_json
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
end # module

