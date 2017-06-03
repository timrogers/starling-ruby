require 'spec_helper'

RSpec.describe Starling::Resources::OutboundFasterPaymentsTransactionResource do
  subject(:transaction) { described_class.new(response: response) }
  let(:fixture) { load_fixture('outbound_faster_payments_transaction.json') }
  let(:response) { double(body: fixture, status: 200, headers: {}) }

  its(:created) { is_expected.to eq(Time.parse('2017-05-19T06:28:05.158Z')) }
  its(:created_at) { is_expected.to eq(Time.parse('2017-05-19T06:28:05.158Z')) }

  its(:id) { is_expected.to eq('b7f69386-860f-49b6-9e9d-97b46fefb658') }
  its(:currency) { is_expected.to eq('GBP') }
  its(:amount) { is_expected.to eq(-15.9) }
  its(:direction) { is_expected.to eq(:outbound) }
  its(:narrative) { is_expected.to eq('2184EMPH000604') }
  its(:source) { is_expected.to eq(:faster_payments_out) }
  its(:receiving_contact_id) do
    is_expected.to eq('7eb7c22e-9a3d-4c25-b4ec-d75a115656ff')
  end
  its(:receiving_contact_account_id) do
    is_expected.to eq('7eb7c22e-9a3d-4c25-b4ec-d75a115656ff')
  end
end
