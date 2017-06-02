require 'spec_helper'

RSpec.describe Starling::Resources::DirectDebitMandateResource do
  subject(:direct_debit_mandate) { described_class.new(response: response) }
  let(:fixture) { load_fixture('direct_debit_mandate.json') }
  let(:response) { double(body: fixture, status: 200, headers: {}) }

  its(:created) { is_expected.to eq(Time.parse('2017-05-31T08:07:54.618Z')) }
  its(:created_at) { is_expected.to eq(Time.parse('2017-05-31T08:07:54.618Z')) }

  its(:reference) { is_expected.to eq('Y8BMVK7') }
  its(:status) { is_expected.to eq(:live) }
  its(:source) { is_expected.to eq(:electronic) }
  its(:originator_name) { is_expected.to eq('GC re Tim Rogers') }
  its(:originator_uid) { is_expected.to eq('4604224f-c81d-4c34-908b-b9f57fc60d51') }
end
