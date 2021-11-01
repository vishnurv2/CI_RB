# frozen_string_literal: true

class DocumentsForwardModal < BaseModal
  UPLOAD_HOOKS ||= CptHook.define_hooks do
    after(:set).call(:wait_for_upload)
  end

  file_field(:file_to_upload, id: 'DocumentDropBox', hooks: UPLOAD_HOOKS)
  span(:document_name, name: 'ForwardRowDocument')
  span(:applies_to, name: 'ForwardRowApplies')
  span(:document_status, name: 'ForwardStatusRow')

  def wait_for_upload
    Watir::Wait.until { document_status == 'Uploaded' }
  end
end
