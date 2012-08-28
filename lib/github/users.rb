module Github
  class Users < Base
    def get(id)
      JSON.parse(api_request("/users/#{id}", 'GET'))
    end
  end
end