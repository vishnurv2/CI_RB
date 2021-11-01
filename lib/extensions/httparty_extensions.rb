# frozen_string_literal: true

# This monkey patch makes HTTParty support NTLM authentication
# To use NTLM auth, supply a :ntlm_auth key in your options hash.
# This hash can contain the following:
#   :username - If not supplied, will be pulled from the environment variable USERNAME
#   :domain - If not supplied, will be pulled from the environment variable USERDOMAIN
#   :password - This must be supplied no default exists.

require 'httparty_with_cookies'
require 'ntlm/http'
require 'json'

module HTTParty
  class Request
    private

    def setup_raw_request
      @raw_request = http_method.new(request_uri(uri))

      # Begin monkey patch.  This is the only part of the code we've modified
      if @options[:ntlm_auth]
        @raw_request.ntlm_auth(@options[:ntlm_auth].fetch(:username, Nenv.username),
                               @options[:ntlm_auth].fetch(:username, Nenv.userdomain),
                               @options[:ntlm_auth][:password])
      end
      # end monkey patch
      #
      @raw_request.body_stream = options[:body_stream] if options[:body_stream]

      if options[:headers].respond_to?(:to_hash)
        headers_hash = options[:headers].to_hash
        @raw_request.initialize_http_header(headers_hash)
        # If the caller specified a header of 'Accept-Encoding', assume they want to
        # deal with encoding of content. Disable the internal logic in Net:HTTP
        # that handles encoding, if the platform supports it.
        if @raw_request.respond_to?(:decode_content) && (headers_hash.key?('Accept-Encoding') || headers_hash.key?('accept-encoding'))
          # Using the '[]=' sets decode_content to false
          @raw_request['accept-encoding'] = @raw_request['accept-encoding']
        end
      end

      if options[:body]
        body = Body.new(
            options[:body],
            query_string_normalizer: query_string_normalizer,
            force_multipart: options[:multipart]
        )

        if body.multipart?
          content_type = "multipart/form-data; boundary=#{body.boundary}"
          @raw_request['Content-Type'] = content_type
        end
        @raw_request.body = body.call
      end

      if options[:basic_auth] && send_authorization_header?
        @raw_request.basic_auth(username, password)
        @credentials_sent = true
      end
      setup_digest_auth if digest_auth? && response_unauthorized? && response_has_digest_auth_challenge?
    end
  end
end