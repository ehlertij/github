module Github
  class PullRequests < Base
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

    def comments(id)
      JSON.parse(api_request("/pulls/#{id}/comments", 'GET'))
    end
  end
end