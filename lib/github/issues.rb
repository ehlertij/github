module Github
  class Issues < Base
    def get(id)
      JSON.parse(api_request("/issues/#{id}", 'GET'))
    end

    def list(options={})
      JSON.parse(api_request("/issues", 'GET', options))
    end

    def create(options={})
      JSON.parse(api_request("/issues", 'POST', options))
    end

    def update(id, options={})
      JSON.parse(api_request("/issues/#{id}", 'PATCH', options))
    end

    def create_label(options={})
      JSON.parse(api_request("/labels", 'POST', options))
    end

    def delete_label(id)
      JSON.parse(api_request("/labels/#{id}", 'DELETE'))
    end
  end
end