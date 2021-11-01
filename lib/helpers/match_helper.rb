# frozen_string_literal: true
#

# Central Insurance Matchers/PDF support - DDL - 2020
# PDFHelpers, methods to aid in PDF verification
class PDFHelper
  include Singleton

  def self.method_missing(message, *args, &block)
    PDFHelper.instance.send(message, *args, &block)
  end

  ## Match text in PDF text
  #
  # @param text - entire text string
  # @param expected - expected text to find
  #
  # @return true, nil if false
  def match_text(text, expected)
    unless text.match(/#{expected}/).nil?
      text.match(/#{expected}/)[0].to_s
    end

    false
  end


  def _save_blob(blob, filename)
    "function saveFile(blob, filename) {
        if (window.navigator.msSaveOrOpenBlob) {
          window.navigator.msSaveOrOpenBlob(blob, filename);
        } else {
          const a = document.createElement('a');
          document.body.appendChild(a);
          const doc = new Blob([blob], { type: 'application/pdf' })
          const url = window.URL.createObjectURL(doc);
          a.href = url;
          a.download = filename;
          a.click();
          setTimeout(() => {
            //window.URL.revokeObjectURL(url);
            document.body.removeChild(a);
          }, 0)
        }
      }
      saveFile('#{blob}', '#{filename}');"
  end

end

