require 'spec_helper'

RSpec.describe Starling::Resources::CustomerResource do
  subject(:error) { described_class.new(response: response) }
  let(:fixture) { load_fixture('customer.json') }
  let(:response) { double(body: fixture, status: 200, headers: {}) }

  its(:customer_uid) { is_expected.to eq('88c4d569-01cc-4217-9bc0-0387b6f7f65d') }
  its(:first_name) { is_expected.to eq('Timothy David') }
  its(:last_name) { is_expected.to eq('Rogers') }
  its(:date_of_birth) { is_expected.to eq(Date.new(1984, 12, 25)) }
  its(:email) { is_expected.to eq('me@timrogers.co.uk') }
  its(:phone) { is_expected.to eq('+447969999999') }
end
