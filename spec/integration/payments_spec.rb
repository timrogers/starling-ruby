require 'spec_helper'

RSpec.describe Starling::Services::PaymentsService do
  let(:client) { Starling::Client.new(access_token: 'dummy_access_token') }
  subject(:service) { client.payments }

  before { stub_user_agent }

  describe '#list' do
    subject(:payments) { service.list }

    let(:status) { 200 }
    let(:body) { load_fixture('payments.json') }
    let(:headers) { { 'Content-Type' => 'application/json' } }

    before do
      stub_request(:get, 'https://api.starlingbank.com/api/v1/payments/scheduled')
        .with(headers: {
                'Accept' => 'application/json',
                'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'Authorization' => 'Bearer dummy_access_token',
                'User-Agent' => user_agent
              })
        .to_return(status: status,
                   body: body,
                   headers: headers)
    end

    its(:length) { is_expected.to eq(2) }

    it 'correctly constructs an array of Payment resources',
       :aggregate_failures do
      expect(payments.first.payment_order_id)
        .to eq('820cf8ee-1ed2-460e-b05a-b16db1d81624')
      expect(payments.first.currency).to eq('GBP')
      expect(payments.first.amount).to eq(1520.0)
      expect(payments.first.reference).to eq('QQT65230L')
      expect(payments.first.receiving_contact_account_id)
        .to eq('7b433266-ff08-4d0d-b4be-a5e9fb08f55a')
      expect(payments.first.recipient_name).to be_nil
      expect(payments.first.immediate).to be(false)
      expect(payments.first.start_date).to eq(Date.parse('2017-06-09'))
      expect(payments.first.next_date).to eq(Date.parse('2017-06-09'))
      expect(payments.first.cancelled_at).to eq(Time.parse('2017-05-28T17:53:49.066Z'))
      expect(payments.first.payment_type).to eq(:standing_order)
      expect(payments.first.recurrence_rule).to eq('startDate' => '2017-06-09',
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
