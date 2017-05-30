require 'spec_helper'

RSpec.describe Starling::Resources::AccountResource do
  subject(:error) { described_class.new(response: response) }
  let(:fixture) { load_fixture('account.json') }
  let(:response) { double(body: fixture, status: 200, headers: {}) }

  its(:created_at) { is_expected.to eq(Time.parse('2017-05-17T12:00:00.000Z')) }
  its(:currency) { is_expected.to eq('GBP') }
  its(:iban) { is_expected.to eq('GB19SRLG60837199999999') }
  its(:number) { is_expected.to eq('99999999') }
  its(:sort_code) { is_expected.to eq('608371') }
  its(:bic) { is_expected.to eq('SRLGGB2L') }
  its(:id) { is_expected.to eq('cac60dc8-4448-11e7-a919-92ebcb67fe33') }
  its(:name) { is_expected.to eq('8d07ea72a-4448-11e7-a919-92ebcb67fe33 GBP') }
end
