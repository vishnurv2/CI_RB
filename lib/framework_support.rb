# frozen_string_literal: true

# Third party requires
require 'pry'
require 'data_magic'
require 'edsl/page_object'
require 'chauffeur'
require 'chronic'
require 'active_support'

#POC
require 'webdrivers'

# Central API Gems
require 'authorization_server_client'
require 'account_api_core_client'
require 'policy_api_core_client'
require 'policy_api_core_client_v2a'
require 'documents_api_client'
require 'documaker_api_client'

# Internal code
require 'nenv_vars'
require 'constants'
require 'magic_paths'
require 'pdf-reader'
require 'zip'
require 'extensions/to_page_class'
require 'extensions/data_magic_extensions'
require 'extensions/applicant_extensions'
require 'extensions/property_extensions'
require 'extensions/capture_assertions'
require 'extensions/hash_slice'
require 'extensions/angularjs'
require 'extensions/httparty_extensions'
require 'extensions/unicode_set'
require 'extensions/select_index'
require 'extensions/edsl_extensions'
require 'extensions/api_client'
#require 'extensions/takes_screenshot'

# Moneky Patches for PolicyApiCore - because its dumb
require 'extensions/policy_api/driver_assignments_api'
require 'extensions/policy_api/drivers_api'
require 'extensions/policy_api/general_info_api'
require 'extensions/policy_api/policies_api'
require 'extensions/policy_api/code_lists_api'
require 'extensions/policy_api/coverages_api'
require 'extensions/policy_api/vehicles_api'
require 'extensions/policy_api/reports_api'
require 'extensions/policy_api/api_client'
require 'extensions/policy_api/policy_activities_api'

# Helpers
require 'helpers/paths'
require 'helpers/browser'
require 'helpers/app_error_helper'
require 'helpers/cleanup_helper'
require 'helpers/policy_transfer_helper'
require 'helpers/fixtures'
require 'helpers/api_helper'
require 'helpers/tfs_auditor'
require 'helpers/fake_data_helper'
require 'helpers/toaster_helper'
require 'helpers/match_helper'
require 'helpers/test_data_import_helper'
require 'helpers/integration_helper'
require 'element_hooks'
require 'pages'
require 'helpers/route_helper'
require 'matchers/element'
require 'helpers/ruby_excel_helper'
require 'helpers/json_data_helper'
require 'helpers/policy_api_helper'
require 'helpers/database_helper'

# Other APIs
require 'apis/tfs_client'

# Allure
require 'allure-cucumber'
require 'allure-ruby-commons'
require 'allure-rspec'

# Redis
require 'redis'

#PACT
require 'pact'
