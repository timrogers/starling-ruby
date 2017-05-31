module IntegrationTests
  # ApiService#user_agent builds a User-Agent header to send to the API using various
  # details about the current environment (e.g. Ruby version). We'll stub this before
  # integration tests so they are not environment-dependent.
  def stub_user_agent
    allow_any_instance_of(Starling::ApiService).to receive(:user_agent)
      .and_return(user_agent)
  end

  def user_agent
    'starling-ruby/v0.1.0 ruby/2.4.1p111 ruby/2.4.1 x86_64-darwin16 faraday/0.9.2'
  end
end
