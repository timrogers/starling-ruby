require 'uri'

module Starling
  class Client
    ENVIRONMENT_BASE_URLS = {
      production: 'https://api.starlingbank.com',
      sandbox: 'https://api-sandbox.starlingbank.com'
    }.freeze

    def initialize(access_token:, environment: :production, default_headers: {},
                   connection_options: {})
      @api_service = ApiService.new(fetch_base_url_for_environment(environment),
                                    access_token: access_token,
                                    default_headers: default_headers,
                                    connection_options: connection_options)
    end

    def account
      Services::AccountService.new(@api_service)
    end

    def account_balance
      Services::AccountBalanceService.new(@api_service)
    end

    def transactions
      Services::TransactionsService.new(@api_service)
    end

    def merchants
      Services::MerchantsService.new(@api_service)
    end

    def merchant_locations
      Services::MerchantLocationsService.new(@api_service)
    end

    def card
      Services::CardService.new(@api_service)
    end

    def me
      Services::MeService.new(@api_service)
    end

    def customer
      Services::CustomerService.new(@api_service)
    end

    def addresses
      Services::AddressesService.new(@api_service)
    end

    def direct_debit_mandates
      Services::DirectDebitMandatesService.new(@api_service)
    end

    def contacts
      Services::ContactsService.new(@api_service)
    end

    def contact_accounts
      Services::ContactAccountsService.new(@api_service)
    end

    private

    def fetch_base_url_for_environment(environment)
      ENVIRONMENT_BASE_URLS.fetch(environment) do
        raise ArgumentError, "#{environment} is not a valid environment, must be one " \
                             "of #{ENVIRONMENT_BASE_URLS.keys.join(', ')}"
      end
    end
  end
end
