require 'spec_helper'

RSpec.describe Starling::Resources::TransactionResource do
  subject(:error) { described_class.new(response: response) }
  let(:fixture) { load_fixture('transaction.json') }
  let(:response) { double(body: fixture, status: 200, headers: {}) }

  its(:created) { is_expected.to eq(Time.parse('2017-05-30T18:06:28.773Z')) }
  its(:created_at) { is_expected.to eq(Time.parse('2017-05-30T18:06:28.773Z')) }

  its(:id) { is_expected.to eq('284ad156-cb66-465c-8757-f6440304a0f8') }
  its(:currency) { is_expected.to eq('GBP') }
  its(:amount) { is_expected.to eq(-1.02) }
  its(:direction) { is_expected.to eq(:outbound) }
  its(:narrative) { is_expected.to eq('Aldi') }
  its(:source) { is_expected.to eq(:master_card) }
end
