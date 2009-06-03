module BlipTV
  class ApiSpec
    VIDEOS_UPLOAD_ATTRS = {
      :required => [
        :title,
        :file,
      ],   
      :optional => [
        :thumbnail,
        :nsfw,
        :description,
        :username,
        :password,
        :keywords,
        :categories,
        :license,
        :interactive_post
      ]
    }
  
    def self.check_attributes(bliptv_method, attributes)
      valid_attributes = bliptv_method_to_const(bliptv_method)
      required = valid_attributes[:required] || Array.new
      optional = valid_attributes[:optional] || Array.new
    
      attributes.assert_valid_keys(required + optional)
      attributes.assert_required_keys(required)
    end
  
    protected
  
    def self.bliptv_method_to_const(method)
      const_name = method.gsub('.', '_').upcase
      const_get("#{const_name}_ATTRS")
    end
  end
end