# frozen_string_literal: true

class PolicyTransferHelper
  def self.transfer_policies(header_params, original, new)
    data = {
        "from_account_id": "#{original}",
        "to_account_id": "#{new}"
    }
    header_params.merge!(data)
    transfer = AccountAPI::AccountsApi.new

    begin
      transfer.v1_accounts_actions_transfer_policies_post_with_http_info(header_params)
      true
    rescue Exception => e
      raise "Failed to transfer policies from account #{original} to #{new} - #{e.message}"
    end
  end
end
