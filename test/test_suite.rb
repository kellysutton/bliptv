require 'test/unit'
require 'test/unit/testsuite'
require 'test/unit/ui/console/testrunner'

require 'test/test_video'
require 'test/test_base'

class TS_BlipTVTests
  def self.suite
    suite = Test::Unit::TestSuite.new "Blip.tv gem tests"
    suite << TC_VideoTest.suite
    suite << TC_BaseTest.suite
    return suite
  end
end
Test::Unit::UI::Console::TestRunner.run(TS_BlipTVTests)