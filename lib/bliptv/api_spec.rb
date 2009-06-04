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
        :userlogin,
        :password,
        :keywords,
        :categories,
        :license,
        :interactive_post
      ]
    }
    
    VIDEOS_DELETE_ATTRS = {
      :required => [
        :userlogin,
        :password
        ],
      :optional => [
        :username # kind of sloppy, because a user is unlikely to specify both a userlogin AND a username
      ]
    }
  
    def self.check_attributes(bliptv_method, attributes)
      valid_attributes = bliptv_method_to_const(bliptv_method)
      required = valid_attributes[:required] || Array.new
      optional = valid_attributes[:optional] || Array.new
    
      # blip calls it a "userlogin" instead of a "username"
      if attributes[:username] != nil 
        attributes[:userlogin] = attributes[:username]
        attributes.delete(:username)
      end
    
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