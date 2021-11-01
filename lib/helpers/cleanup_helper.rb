# frozen_string_literal: true

require 'fileutils'

class CleanupHelper
  include Singleton

  def self.method_missing(message, *args, &block)
    CleanupHelper.instance.send(message, *args, &block)
  end

  attr_accessor :allow_registration

  def file_to_save
    dirname = File.dirname(File.expand_path('..'))
    name = "#{dirname}/accounts"
    unless File.directory?(name)
      FileUtils.mkdir_p(name)
      FileUtils.mkdir_p("#{name}/logs")
    end

    @file_to_save = "#{name}/#{Time.now.strftime('%m-%d-%Y')}.#{Nenv.instance.test_env}"
  end

  def accounts_needing_removed
    @accounts_needing_removed ||= []
  end

  def activities_needing_removed
    @activities_needing_removed ||= []
  end

  def register_toast_bucket
    @error_toasts ||= []
  end

  ## TODO  we dont really need to use register_activity_for_deletion.
  #  if we are creating an auto-policy - just grab the new AccountID and register it.
  def register_account_for_deletion(id_or_url)
    return unless allow_registration

    id = id_or_url.to_s.start_with?('http') ? id_or_url.split('/').last : id_or_url
    accounts_needing_removed << id
    msg = "#{id}\n"
    File.write(file_to_save, msg, mode: 'a')
  end

  ## This usually gets called when creating a new Auto Policy.
  def register_activity_for_deletion(id_or_url)
    return unless allow_registration

    id = id_or_url.to_s.start_with?('http') ? id_or_url.split('/').last : id_or_url
    activities_needing_removed << id
  end

  # this gets called in HOOKS.RB - in the after step because we need to record the account from policyactivityid
  def add_accounts_from_activities
    # need to get the Token!
    #
    tok = Helpers::Fixtures.load_fixture('authorization_server_api') # creds file
    @creds = tok['api']
    @token = APIHelper.get_auth_token(@creds)

    header_params = APIHelper.header_params(@token)
    policy_api = PolicyAPI::GeneralInfoApi.new

    activities_needing_removed.each do |act|
      STDOUT.puts "Looking up account for activity ID #{act}"
      begin
        raw = policy_api.get(act, header_params)
        id = raw.to_hash[:basicPolicyInfo][:accountId]
        STDOUT.puts "Marking this policy: #{act} and this account: #{id} for deletion!"
        #id = policy_api.policies_get_policy_activity_by_activity_id(act)[:AccountId]
        accounts_needing_removed << id unless id.to_s.empty?
        id unless id.to_s.empty?
        msg = "#{id}\n"
        File.write(file_to_save, msg, mode: 'a')
      rescue Exception => ex
        STDOUT.puts "Failed to fetch accounts from activity #{act} #{ex.message}"
      end
    end
  end

  def cleanup_accounts
    # I think this is a leftover from the old process?
    #account_api = AccountAPI::DELETEApi.new
    add_accounts_from_activities  ### when I get here, May not need this,

    accounts_needing_removed.map(&:to_s).uniq.each do |id|
      #remove_account(account_api, id)
      # need the token
      remove_account(id, token)
    end
  end

  def remove_account(id, token)
    t = Time.now
    STDOUT.write "Removing account #{id}..."
    begin
      APIHelper.delete_account(token, id)
      STDOUT.puts " Took #{Time.now - t} seconds"
    rescue Exception => ex
      STDOUT.puts "Failed to remove account #{id} -  #{ex.message}"
    end
  end

  # Old cleanup method to remove accounts right after the tests complete
  def cleanup
    cleanup_accounts
  end

  # Called from the AFTER step in Hooks
  def mark_for_cleanup
    add_accounts_from_activities
  end

  # This will be called in a post deploy script
  def post_run_cleanup(file, token)
    arr = []
    text = File.open(file).read
    text.each_line { |line| arr << line.split("\n").join }
    arr.map(&:to_s).uniq.each do |id|
      remove_account(id, token)
      sleep(7) # delay
    end
  end
end
