module Starling
  module Resources
    class CustomerResource < BaseResource
      def customer_uid
        parsed_data['customerUid']
      end

      def first_name
        parsed_data['firstName']
      end

      def last_name
        parsed_data['lastName']
      end

      def date_of_birth
        present_date(parsed_data['dateOfBirth'])
      end

      def email
        parsed_data['email']
      end

      def phone
        parsed_data['phone']
      end
    end
  end
end
