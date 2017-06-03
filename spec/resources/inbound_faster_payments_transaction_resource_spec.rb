require 'spec_helper'

RSpec.describe Starling::Resources::InboundFasterPaymentsTransactionResource do
  subject(:transaction) { described_class.new(response: response) }
  let(:fixture) { load_fixture('inbound_faster_payments_transaction.json') }
  let(:response) { double(body: fixture, status: 200, headers: {}) }

  its(:created) { is_expected.to eq(Time.parse('2017-05-31T23:54:40.915Z')) }
  its(:created_at) { is_expected.to eq(Time.parse('2017-05-31T23:54:40.915Z')) }

  its(:id) { is_expected.to eq('29a05688-f8a0-49f8-9148-b52a087ee360') }
  its(:currency) { is_expected.to eq('GBP') }
  its(:amount) { is_expected.to eq(492) }
  its(:direction) { is_expected.to eq(:inbound) }
  its(:narrative) { is_expected.to eq('sw8 deposit') }
  its(:source) { is_expected.to eq(:faster_payments_in) }
  its(:sending_contact_id) { is_expected.to eq('ae46414c-7cc4-44f6-8be3-d6a2296f5700') }
  its(:sending_contact_account_id) do
    is_expected.to eq('ae46414c-7cc4-44f6-8be3-d6a2296f5700')
  end
end
