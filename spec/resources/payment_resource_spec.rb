require 'spec_helper'

RSpec.describe Starling::Resources::PaymentResource do
  subject(:payment) { described_class.new(response: response) }
  let(:fixture) { load_fixture('payment.json') }
  let(:response) { double(body: fixture, status: 200, headers: {}) }

  its(:payment_order_id) { is_expected.to eq('820cf8ee-1ed2-460e-b05a-b16db1d81624') }
  its(:id) { is_expected.to eq('820cf8ee-1ed2-460e-b05a-b16db1d81624') }

  its(:currency) { is_expected.to eq('GBP') }
  its(:amount) { is_expected.to eq(1520.0) }
  its(:reference) { is_expected.to eq('QQT65230L') }
  its(:receiving_contact_account_id) do
    is_expected.to eq('7b433266-ff08-4d0d-b4be-a5e9fb08f55a')
  end
  its(:recipient_name) { is_expected.to be_nil }
  its(:immediate) { is_expected.to be(false) }
  its(:start_date) { is_expected.to eq(Date.parse('2017-06-09')) }
  its(:next_date) { is_expected.to eq(Date.parse('2017-06-09')) }
  its(:cancelled_at) { is_expected.to eq(Time.parse('2017-05-28T17:53:49.066Z')) }
  its(:payment_type) { is_expected.to eq(:standing_order) }

  describe '#recurrence_rule' do
    subject(:recurrence_rule) { payment.recurrence_rule }

    it 'builds a correct Hash' do
      expect(recurrence_rule).to eq('startDate' => '2017-06-09',
                                    'frequency' => 'MONTHLY',
                                    'interval' => 1,
                                    'count' => nil,
                                    'untilDate' => nil,
                                    'weekStart' => nil,
                                    'days' => [],
                                    'monthDay' => 9,
                                    'monthWeek' => nil)
    end
  end
end
