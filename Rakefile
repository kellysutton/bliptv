require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('bliptv', '0.1.0') do |p|
  p.description               = "A Ruby library from Blip.tv"
  p.url                       = "http://github.com/kellysutton/bliptv"
  p.author                    = "Michael Kelly Sutton"
  p.email                     = "michael.k.sutton@gmail.com"
  p.ignore_pattern            = ["tmp/*", "script/*"]
  p.development_dependencies  = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }