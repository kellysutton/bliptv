#
# This is the main entry point for the library. All files in the project are
# included here, as well as anything required across the project.
#

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'active_support'
require 'ostruct'
require 'net/http'
require 'uri'

require 'ext/array'
require 'ext/hash'
require 'ext/open_struct'

require 'bliptv/base'
require 'bliptv/video'
require 'bliptv/api_spec'
require 'bliptv/multipart_params'
require 'bliptv/request'


module BlipTV
end