module Github
  class PullRequests < Base
    class << self
      def get(id)
        JSON.parse(api_request("/pulls/#{id}", 'GET'))
      end

      def list(options={})
        JSON.parse(api_request("/pulls", 'GET', options))
      end

      def create(options={})
        JSON.parse(api_request("/pulls", 'POST', options))
      end

      def update(id, options={})
        JSON.parse(api_request("/pulls/#{id}", 'PATCH', options))
      end
    end
  end
end