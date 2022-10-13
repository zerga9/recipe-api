# frozen_string_literal: true

module ApiHelpers
  def login(user)
    post '/login', params: { user: { username: user.username, password: user.password } }
  end

  def json_body
    JSON.parse(response.body).deep_symbolize_keys
  end

  def json_data
    json_body[:data]
  end
end
