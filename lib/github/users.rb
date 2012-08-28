module Github
  class Users < Base
    def base_url
      "https://api.github.com"
    end

    def get(id)
      JSON.parse(api_request("/users/#{id}", 'GET'))
    end
  end
end