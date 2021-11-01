# frozen_string_literal: true

module EDSL
  module PageObject
    module Javascript

      module AngularJS
        #
        # return the number of pending ajax requests works for Angular 5 +
        # DDL - 1/27/2020
        #
        def self.pending_requests
          'return window.getAllAngularTestabilities().findIndex(x=>!x.isStable()) === -1'
          #window.getAllAngularTestabilities().some(x => x.isStable() === false)  returns true if found
        end

        def self.macro_tasks
          'return window.getAllAngularTestabilities()[0]._ngZone.hasPendingMacrotasks'
        end
      end

    end
  end
end
