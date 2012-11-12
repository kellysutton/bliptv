require 'rest_client'

module BlipTV

  # Raised when response from Blip.tv contains absolutely no data
  class EmptyResponseError < BlipTVError #:nodoc:
  end

  # Raised when response from Blip.tv contains an error
  class ResponseError < BlipTVError #:nodoc:
    def initialize(message)
      super message
    end
  end

  # Class used to send requests over http to Viddler API.
  class Request #:nodoc:

    API_URL = 'http://uploads.blip.tv/'
    DEFAULT_HEADERS = {:accept => 'application/xml', :content_type => 'multi-part/form-data'}

    attr_accessor :url, :http_method, :response, :body
    attr_reader :headers, :params

    def initialize(http_method, method) #:nodoc:
      @http_method = http_method.to_s
      @url = API_URL
      self.params = {} #{:method => viddlerize(method)}
      self.headers = DEFAULT_HEADERS
    end

    # Use this method to setup your request's payload and headers.
    #
    # Example:
    #
    #   request.set :headers do |h|
    #     h.content_type = 'application/ufo'
    #   end
    #
    #   request.set :params do |p|
    #     p.sessionid = '12323'
    #     p.api_key   = '13123
    #   end
    #
    def set(container, &declarations)
      struct = OpenStruct.new
      declarations.call(struct)
      send("#{container}=", struct.table)
    end

    # Send http request to Viddler API.
    def run(&block)
      if block_given?
        set(:params, &block)
      end

      if post? and multipart?
        put_multipart_params_into_body
      else
        put_params_into_url
      end

      request = RestClient::Request.execute(
         :method => http_method,
         :url => url,
         :headers => headers,
         :payload => body
       )
       self.response = parse_response(request)
    end

    private

    def parse_response(raw_response)
      raise EmptyResponseError if raw_response.blank?
      response_hash = Hash.from_xml(raw_response)
      begin
        if response_error = response_hash["otter_responses"]["response"]["error"]
          raise ResponseError.new(bliptv_error_message(response_error))
        end
      rescue # we don't care if it fails, that means it works
      end
      response_hash["post_url"] = raw_response.match(/\d{3,12}/)[0] # extracts the post_url, since from_xml isn't grabbing it
      response_hash
    end

    def put_multipart_params_into_body
      multiparams = MultipartParams.new(params)
      self.body = multiparams.body
      self.headers = {:content_type => multiparams.content_type}
    end

    def put_params_into_url
      self.url = API_URL + '?' + params.to_query
    end

    def viddlerize(name)
      if name.include?('viddler.')
        name
      else
        'viddler.' + name
      end
    end

    def params=(hash) #:nodoc:
      @params ||= Hash.new
      @params.update(hash)
    end

    def headers=(hash) #:nodoc:
      @headers ||= Hash.new
      @headers.update(hash)
    end

    def multipart? #:nodoc:
      # TOOD let's be nice and do a File.exists?(v)
      if params.find{|k,v| v.is_a?(File)} then true else false end
    end

    def post? #:nodoc:
      http_method == 'post'
    end

    def bliptv_error_message(response_error)
      description = response_error['description'] || ''
      details = response_error['details'] || ''
      code = response_error['code'] || ''

      details = ": #{details};" unless details.empty?
      code = " [code: #{code}]" unless code.empty?
      %Q[#{description}#{details}#{code}]
    end

  end
end