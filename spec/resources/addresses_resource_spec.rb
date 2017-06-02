require 'spec_helper'
require 'json'

RSpec.describe Starling::Resources::AddressesResource do
  subject(:addresses) { described_class.new(response: response) }
  let(:fixture) { load_fixture('addresses.json') }
  let(:response) { double(body: fixture, status: 200, headers: {}) }

  its(:current) { is_expected.to be_a(Starling::Resources::AddressResource) }

  describe '#previous' do
    it 'returns an array of Address resources' do
      expect(addresses.previous.map(&:class).uniq)
        .to eq([Starling::Resources::AddressResource])
    end
  end
end
