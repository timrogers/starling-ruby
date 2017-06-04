require 'spec_helper'

RSpec.describe Starling::Resources::MastercardTransactionResource do
  subject(:transaction) { described_class.new(response: response) }
  let(:fixture) { load_fixture('mastercard_transaction.json') }
  let(:response) { double(body: fixture, status: 200, headers: {}) }

  its(:created) { is_expected.to eq(Time.parse('2017-05-31T17:48:02.253Z')) }
  its(:created_at) { is_expected.to eq(Time.parse('2017-05-31T17:48:02.253Z')) }

  its(:id) { is_expected.to eq('3b29c081-e824-4db3-ade4-9deffbd839a2') }
  its(:currency) { is_expected.to eq('GBP') }
  its(:amount) { is_expected.to eq(-1.5) }
  its(:direction) { is_expected.to eq(:outbound) }
  its(:narrative) { is_expected.to eq('TFL Travel Charge') }
  its(:source) { is_expected.to eq(:master_card) }
  its(:mastercard_transaction_method) { is_expected.to eq(:contactless) }
  its(:status) { is_expected.to eq(:settled) }
  its(:source_amount) { is_expected.to eq(1.5) }
  its(:source_currency) { is_expected.to eq('GBP') }
  its(:merchant_id) { is_expected.to eq('0a51eab9-5e6b-4572-b9f4-80bbf91f8fbf') }
  its(:merchant_location_id) do
    is_expected.to eq('9fcc6444-9c1d-404c-8f8f-02910a04a102')
  end
end
