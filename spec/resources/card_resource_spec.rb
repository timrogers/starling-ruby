require 'spec_helper'

RSpec.describe Starling::Resources::CardResource do
  subject(:card) { described_class.new(response: response) }
  let(:fixture) { load_fixture('card.json') }
  let(:response) { double(body: fixture, status: 200, headers: {}) }

  its(:id) { is_expected.to eq('2125b5ce-5651-4ebe-9ef9-50b1703508bb') }
  its(:name_on_card) { is_expected.to eq('Timothy David Rogers') }
  its(:type) { is_expected.to eq('ContactlessDebitMastercard') }
  its(:enabled) { is_expected.to be(true) }
  its(:cancelled) { is_expected.to be(false) }
  its(:activation_requested) { is_expected.to be(true) }
  its(:activated) { is_expected.to be(true) }
  its(:dispatch_date) { is_expected.to eq(Date.new(2017, 5, 19)) }
end
