require 'spec_helper'
require 'json'

RSpec.describe Starling::Resources::AddressResource do
  subject(:error) { described_class.new(parsed_data: address) }
  let(:fixture) { load_fixture('addresses.json') }
  let(:parsed_data) { JSON.parse(fixture) }
  let(:address) { parsed_data['current'] }
  let(:response) { double(body: fixture, status: 200, headers: {}) }

  its(:street_address) { is_expected.to eq('Flat 006') }
  its(:city) { is_expected.to eq('LONDON') }
  its(:country) { is_expected.to eq('GBR') }
  its(:postcode) { is_expected.to eq('SE14 5FA') }
end
