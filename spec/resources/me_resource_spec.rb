require 'spec_helper'

RSpec.describe Starling::Resources::MeResource do
  subject(:me) { described_class.new(response: response) }
  let(:fixture) { load_fixture('me.json') }
  let(:response) { double(body: fixture, status: 200, headers: {}) }

  its(:customer_uid) { is_expected.to eq('88c4d569-01cc-4217-9bc0-0387b6f7f65d') }
  its(:authenticated) { is_expected.to be(true) }
  its(:expires_in_seconds) { is_expected.to eq(0) }
  its(:scopes) do
    is_expected.to match(['account:read',
                          'balance:read',
                          'address:read',
                          'address:edit',
                          'card:read',
                          'customer:read',
                          'mandate:read',
                          'mandate:delete',
                          'payee:create',
                          'payee:read',
                          'transaction:read',
                          'transaction:edit'])
  end
end
